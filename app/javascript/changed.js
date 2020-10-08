window.addEventListener('load', function(){
  const itemPrice = document.getElementById('item-price')
  const addTaxPrice = document.getElementById('add-tax-price')
  const profit = document.getElementById('profit')
  
  
  
  
  itemPrice.addEventListener("input", () => {
    
      addTaxPrice.innerHTML = (Math.floor(itemPrice.value * 0.1)).toLocaleString(),
      profit.innerHTML = (Math.floor(itemPrice.value * 0.9)).toLocaleString(); 
    
  })
})