window.addEventListener('turbo:load', () => {
  // console.log("OK");
  // });

 const priceInput = document.getElementById("item-price");
   priceInput.addEventListener("input", () => {
   // const inputValue = priceInput.value;
   // console.log(inputValue);
   // })

   const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1);
    const addPofitDom = document.getElementById("profit");
    addPofitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
    // console.log(priceInput);
  })
});

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);