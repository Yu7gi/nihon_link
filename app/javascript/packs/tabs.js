document.addEventListener('turbolinks:load', function() {
  const tabs = document.querySelectorAll('.tab-list .tab');
  const tabContents = document.querySelectorAll('.tabbox-contents .tabbox');

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => {
        t.classList.remove('tab-active');
      });
      tabContents.forEach(content => {
        content.classList.remove('box-show');
      });

      tab.classList.add('tab-active');
      const selectedTag = tab.textContent.trim();
      tabContents.forEach(content => {
        if(content.dataset.tag === selectedTag) {
          content.classList.add('box-show');
        } else {
          content.classList.remove('box-show');
        }
      });
    });
  });
});