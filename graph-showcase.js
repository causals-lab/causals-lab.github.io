(() => {
  const section = document.querySelector('.graph-examples');
  if (!section) return;

  const slides = Array.from(section.querySelectorAll('.graph-example-slide'));
  const count = section.querySelector('.graph-example-count');
  const previous = section.querySelector('.graph-example-prev');
  const next = section.querySelector('.graph-example-next');
  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
  let current = 0;
  let timer;

  function show(index) {
    current = (index + slides.length) % slides.length;
    slides.forEach((slide, position) => {
      slide.hidden = position !== current;
    });
    count.textContent = `${String(current + 1).padStart(2, '0')} / ${String(slides.length).padStart(2, '0')}`;
  }

  function stop() {
    window.clearInterval(timer);
    timer = undefined;
  }

  function start() {
    stop();
    if (reducedMotion.matches || document.hidden || section.matches(':hover') || section.contains(document.activeElement) || section.querySelector('details[open]')) return;
    timer = window.setInterval(() => show(current + 1), 9000);
  }

  previous.addEventListener('click', () => { show(current - 1); stop(); });
  next.addEventListener('click', () => { show(current + 1); stop(); });
  section.addEventListener('mouseenter', stop);
  section.addEventListener('mouseleave', start);
  section.addEventListener('focusin', stop);
  section.addEventListener('focusout', () => window.setTimeout(start, 0));
  section.addEventListener('toggle', start, true);
  document.addEventListener('visibilitychange', start);
  reducedMotion.addEventListener('change', start);

  show(0);
  start();
})();
