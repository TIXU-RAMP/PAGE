function proxy() {
  const url = document.getElementById('url').value;
  window.location.href = `/proxy?url=${encodeURIComponent(url)}`;
}
