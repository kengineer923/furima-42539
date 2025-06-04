document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const taxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');
  if (!priceInput) return;

  const setPrice = () => {
    const value = parseInt(priceInput.value, 10);
    if (isNaN(value) || value < 300 || value > 9999999) {
      taxDom.textContent = '';
      profitDom.textContent = '';
      return;
    }
    const tax = Math.floor(value * 0.1);
    const profit = Math.floor(value - tax);
    taxDom.textContent = tax;
    profitDom.textContent = profit;
  };
  setPrice();
  priceInput.addEventListener('input', setPrice);
});

document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById('item-price');
  const taxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');
  if (!priceInput) return;

  const setPrice = () => {
    const value = parseInt(priceInput.value, 10);
    if (isNaN(value) || value < 300 || value > 9999999) {
      taxDom.textContent = '';
      profitDom.textContent = '';
      return;
    }
    const tax = Math.floor(value * 0.1);
    const profit = Math.floor(value - tax);
    taxDom.textContent = tax;
    profitDom.textContent = profit;
  };
  setPrice();
  priceInput.addEventListener('input', setPrice);
});
