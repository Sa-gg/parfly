window.onload = () => {
  const navbar = document.querySelector('.navbar');
  const navLinks = document.querySelectorAll('.navbar .nav-item > .nav-link:not(.signup)');
  const menuBtn = document.getElementById("menu-btn");
  const collapseContent = document.getElementById("navbarSupportedContent")
  const globeIcon = document.querySelector('.fa-globe');
  const userIcon = document.querySelector('.bx-user');

  const toggleNavbar = (isTransparent) => {
    navbar.classList.toggle('bg-body-tertiary', !isTransparent);
    navbar.classList.toggle('bg-transparent', isTransparent);

    const textColor = isTransparent ? 'white' : 'black';
    globeIcon.style.color = isTransparent ? 'white' : 'orange';
    userIcon.style.color = isTransparent ? 'white' : 'orange';

    navLinks.forEach(link => {
      if (link.classList.contains('lang') || link.classList.contains('login')) {
        link.style.color = isTransparent ? 'white' : 'orange'; 
      } else {
        link.style.color = textColor;
      }
    });
  };

  const handleNavbarCollapse = () => {
    if (window.innerWidth <= 1275) {
      navbar.classList.remove('navbar-expand');
      navbar.classList.add('navbar-collapse');
    } else {
      navbar.classList.remove('navbar-collapse');
      navbar.classList.add('navbar-expand');
    }
  };

  let isClickAllowed = true;

menuBtn.addEventListener("click", () => {
  if (!isClickAllowed) return;

  isClickAllowed = false;
  setTimeout(() => {
    isClickAllowed = true;
  }, 400); // Adjust the delay interval as needed (500ms in this case)

  if (window.scrollY === 0 && !collapseContent.classList.contains("show")) {
    toggleNavbar(navbar.classList.contains('bg-body-tertiary'));
  }

  // const isExpanded = menuBtn.getAttribute('aria-expanded') === 'true';
  // menuBtn.setAttribute('aria-expanded', !isExpanded);
  // collapseContent.classList.toggle('show', !isExpanded);
});


  
  window.addEventListener('scroll', () => {
    const isTransparent = window.scrollY === 0 && !collapseContent.classList.contains("show");
    toggleNavbar(isTransparent);
  });

  // Initial setup and window resize listener
  handleNavbarCollapse();
  window.addEventListener('resize', handleNavbarCollapse);
};
