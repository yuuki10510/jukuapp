document.addEventListener("turbo:load", () => {
  const flashes = document.querySelectorAll(".flash");

  if (!flashes.length) return;

  flashes.forEach((flash) => {
    setTimeout(() => {
      flash.classList.add("fade-out");

      // フェードアウト後にDOMから削除
      setTimeout(() => {
        flash.remove();
      }, 400);
    }, 5000); // ← 5秒
  });
});