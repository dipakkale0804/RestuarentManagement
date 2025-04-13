function add_to_cart(pid, pname, price) {
    let cart = localStorage.getItem("cart");

    if (cart == null) {
        // No cart yet
        let products = [];
        let product = { productId: pid, productName: pname, productQuantity: 1, productPrice: price };
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        console.log("Product is added for the first time");
    } else {
        // Cart already present
        let pcart = JSON.parse(cart) || []; // ✅ Ensure `pcart` is always an array

        let oldProduct = pcart.find((item) => item.productId == pid);
        if (oldProduct) {
            // Increase quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;

            pcart = pcart.map((item) => {
                if (item.productId == oldProduct.productId) {
                    item.productQuantity = oldProduct.productQuantity;
                }
                return item;
            });

            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product quantity is increased");
        } else {
            // Add new product
            let product = { productId: pid, productName: pname, productQuantity: 1, productPrice: price };
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product is added");
        }
    }

    updateCart();
}

// Update cart function
function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString) || []; // ✅ Ensure `cart` is always an array

    if (cart.length === 0) {
        console.log("Cart is empty");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any items</h3>");
        $(".checkout-btn").addClass("disabled");
    } else {
        // Display cart items
        console.log(cart);
        $(".cart-items").html(`(${cart.length})`);

        let table = `
<table class="table">
    <thead class='thead-light'>
        <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Action</th>
        </tr>
    </thead>
`;

        let totalPrice = 0;

        cart.map((item) => {
            table += `
            <tr>
                <td>${item.productName}</td>
                <td>${item.productPrice}</td>
                <td>
            <button class="btn btn-sm btn-warning" onclick="decreaseQuantity(${item.productId})">-</button>
                   
                    ${item.productQuantity}
                     <button class="btn btn-sm btn-success" onclick="increaseQuantity(${item.productId})">+</button>
                </td>
                <td>${item.productQuantity * item.productPrice}</td>
                <td>
                    <button onclick='deleteItemFromCart(${item.productId})' class="btn btn-danger btn-sm">Remove</button>
                </td>
            </tr>
            `;
            totalPrice += item.productPrice * item.productQuantity;
        });

        table += `<tr><td colspan='5' class='text-right font-weight-bold m-4'>Total Price: ${totalPrice}</td></tr></table>`;
        $(".cart-body").html(table);
         $(".checkout-btn").removeClass("disabled");
    }
}

// Increase Quantity
function increaseQuantity(pid) {
    let cart = JSON.parse(localStorage.getItem("cart")) || [];
    
    cart = cart.map((item) => {
        if (item.productId == pid) {
            item.productQuantity += 1;
        }
        return item;
    });

    localStorage.setItem("cart", JSON.stringify(cart));
    updateCart();
}

// Decrease Quantity
function decreaseQuantity(pid) {
    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    cart = cart.map((item) => {
        if (item.productId == pid) {
            item.productQuantity -= 1;
        }
        return item;
    }).filter((item) => item.productQuantity > 0); // ✅ Remove item if quantity reaches 0

    localStorage.setItem("cart", JSON.stringify(cart));
    updateCart();
}

// Delete item
function deleteItemFromCart(pid) {
    let cart = JSON.parse(localStorage.getItem("cart")) || [];
    let newcart = cart.filter((item) => item.productId != pid);

    localStorage.setItem("cart", JSON.stringify(newcart));
    updateCart();
}

// Call updateCart on page load
$(document).ready(function () {
    updateCart();
});



        //checkout
        function goToCheckout()
        
{
    window.location="checkout.jsp"
}