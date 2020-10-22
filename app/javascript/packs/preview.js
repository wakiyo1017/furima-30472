document.addEventListener('DOMContentLoaded', function(){
  const ImageList = document.getElementById("image-list");
  
  document.getElementById("item-image").addEventListener("change", function(e){
    const imageContent = document.getElementById("child");
    if (imageContent){
      imageContent.remove();
    }
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    const imageElement = document.createElement("div");
    imageElement.id = 'child';

    const blobImage = document.createElement("img");
    blobImage.className = 'photo-image';
    blobImage.setAttribute("src", blob);

    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
  })
});