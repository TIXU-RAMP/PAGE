// Import Firebase functions
import { initializeApp } from "firebase/app";
import { getDatabase, ref, set, push, onChildAdded } from "firebase/database";

// Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCy2d3KwS6l6hNMOJ3S0Xsfu_znC0q1mBw",
  authDomain: "tixu-1d1e9.firebaseapp.com",
  databaseURL: "https://tixu-1d1e9-default-rtdb.firebaseio.com",
  projectId: "tixu-1d1e9",
  storageBucket: "tixu-1d1e9.firebasestorage.app",
  messagingSenderId: "325853204178",
  appId: "1:325853204178:web:23bf2f7c8447a9455da70b",
  measurementId: "G-91RS0ZYED5"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getDatabase(app);

// Username setup
const randomNames = ["Shadow", "Neon", "Blaze", "Storm", "Phantom", "Rogue", "Vortex", "Glitch", "Nova", "Cipher"];
let username = localStorage.getItem("username");

if (!username) {
  username = randomNames[Math.floor(Math.random() * randomNames.length)] + Math.floor(Math.random() * 1000);
  localStorage.setItem("username", username);
}

// Function to send a message
function sendMessage() {
  const message = document.getElementById("message").value;
  if (message.trim() !== "") {
    const messageId = push(ref(db, 'messages')).key;
    set(ref(db, 'messages/' + messageId), {
      id: messageId,
      user: username,
      text: message,
      timestamp: Date.now()
    });
    document.getElementById("message").value = ""; // Clear the input field
  }
}

// Function to load messages
function loadMessages() {
  const messagesRef = ref(db, 'messages');
  onChildAdded(messagesRef, (snapshot) => {
    const data = snapshot.val();
    const chat = document.getElementById("chat");
    const messageDiv = document.createElement("div");
    messageDiv.innerHTML = `<strong>${data.user}:</strong> ${data.text}`;
    chat.appendChild(messageDiv);
    chat.scrollTop = chat.scrollHeight; // Scroll to bottom
  });
}

// Call loadMessages on page load
loadMessages();
