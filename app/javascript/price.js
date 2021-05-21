function price (){
  if ( document.getElementById("item-price")){
    const itemPrice = document.getElementById("item-price");
    itemPrice.addEventListener("keyup", () => {
      const itemPriceValue = itemPrice.value

      const taxPrice = Math.floor(itemPriceValue / 10);
      const addTaxPrice = document.getElementById("add-tax-price");
      addTaxPrice.innerHTML = taxPrice.toLocaleString();

      const profitTax = itemPriceValue - taxPrice;
      const profit = document.getElementById("profit");
      profit.innerHTML = profitTax.toLocaleString();
    });
  }
};

window.addEventListener('load', price);