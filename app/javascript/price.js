function price (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const itemPriceValue = itemPrice.value

    const taxPrice = itemPriceValue / 10;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = taxPrice;

    const profitTax = itemPriceValue - taxPrice;
    const profit = document.getElementById("profit");
    profit.innerHTML = profitTax;
  });
};

window.addEventListener('load', price);