<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>DSR Food Court</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {font-family: 'Roboto', Arial, sans-serif;margin:0; background: #f8f9fa;}
    .navbar {background: #fff8f3; display:flex; justify-content:space-between; align-items:center; padding:20px 7%; box-shadow:0 1px 8px #eee;}
    .navbar .logo { font-size:2rem; font-weight:700; color:#ff5500; }
    .navbar .nav-btn { background:#ff5500; color:#fff; border:none; border-radius:5px; padding:8px 16px; margin-left:10px; font-size:1rem; cursor:pointer;}
    .navbar .nav-btn:active { background:#d74400;}
    .container { max-width:1100px; margin:40px auto 0 auto; background:#fff; padding:30px; border-radius:13px; box-shadow:0 8px 32px #ddd7;}
    h1 {text-align:center; color:#ff5500; font-size:2.7rem;}
    .subtitle {text-align:center; color:#333; font-size:1.2rem; margin-bottom:40px;}
    /* Restaurant cards */
    .restaurant-list { display:flex; flex-wrap:wrap; gap:30px; justify-content:center;}
    .restaurant-card { background: #faf1eb; border:1px solid #f1d4b7; border-radius:12px; width:230px; padding:16px; text-align:center;
        transition:box-shadow .2s; cursor:pointer; box-shadow:0 2px 12px #0001;}
    .restaurant-card:hover { box-shadow: 0 6px 28px #0002;}
    .restaurant-card img { width:170px; height:95px; border-radius:12px; object-fit:cover;}
    .restaurant-card h3 { margin:11px 0 4px 0;}
    .restaurant-details { color: #222; font-size:.99em; }
    /* Menu grid */
    .menu-section { margin-top:55px;}
    .menu-list { display:flex; gap:22px; flex-wrap:wrap;}
    .menu-card { background: #fffdf8; box-shadow:0 1px 10px #eee; width:220px; border-radius:10px; padding:11px; display:flex; align-items: flex-start; gap:9px;}
    .menu-card img { width:60px; height:60px; border-radius:10px; object-fit:cover;}
    .menu-info { flex:1;}
    .veg-icon { font-size:1.1em;}
    .add-btn { background: #ff5500; color:#fff; border:none; border-radius:5px; padding:5px 12px; margin-top:6px; font-size:1em; cursor:pointer;}
    .add-btn:active { background:#c03e04;}
    /* Cart/offers modal (hidden by default) */
    .modal-bg {display:none; position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,0.3); align-items:center; justify-content:center; z-index:1001;}
    .modal-bg.show { display:flex;}
    .modal {background:#fff; padding:36px; border-radius:14px; box-shadow:0 4px 38px #0004; min-width:340px; min-height:180px; position:relative;}
    .modal .close-x { position:absolute;top:16px;right:18px;font-size:2rem;cursor:pointer;color:#a99;}
    .cart-item {display:flex;justify-content:space-between;align-items:center;margin:10px 0;border-bottom:1px solid #f5d7c2;padding-bottom:7px;}
    .cart-total {font-weight:bold;}
    .checkout-btn { background:#01be83;padding:9px 30px;color:#fff;border:none;font-size:1.09em;border-radius:6px;margin:12px 0 0 0;}
    .checkout-btn:active { background:#037a59;}
    .offer-list {list-style:none; padding:0; line-height:1.7;}
    /* Auth form */
    .auth-form input {display:block;width:96%;margin:16px 0;padding:8px;font-size:1em;}
    /* Footer */
    footer {background:#fff8f3; color:#777; padding:18px 7%; font-size:1em; box-shadow:0 -2px 8px #eee; margin-top:68px;display:flex;align-items:center;justify-content:space-between;}
    /* Responsive */
    @media (max-width:980px) { .container {padding:7vw;} .restaurant-card, .menu-card {width:95vw; max-width:285px;} .menu-list, .restaurant-list {gap:12px;} }
  </style>
</head>
<body>
  <!-- Navigation -->
  <nav class="navbar">
    <div class="logo">DSR Food Court</div>
    <div>
      <button class="nav-btn" onclick="showModal('offers-modal')">Offers</button>
      <button class="nav-btn" onclick="showModal('cart-modal')">Cart <span id="cart-count"></span></button>
      <button class="nav-btn" onclick="showModal('auth-modal')">Sign In</button>
    </div>
  </nav>

  <div class="container">
    <h1>DSR Food Court</h1>
    <div class="subtitle">Order from your favorite outlets. Fresh, fast, and just a click away!</div>

    <!-- Restaurant List -->
    <div class="restaurant-list">
      <!-- Example cards (Repeat as needed) -->
      <div class="restaurant-card" onclick="showMenu('Spice Kitchen')">
        <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=300&q=80" alt="Spice Kitchen" />
        <h3>Spice Kitchen</h3>
        <div class="restaurant-details">North Indian, Chinese</div>
        <div>⭐ 4.5 &middot; 1.2 km</div>
      </div>
      <div class="restaurant-card" onclick="showMenu('Pizza Palace')">
        <img src="https://images.unsplash.com/photo-1542281286-9e0a16bb7366?auto=format&fit=crop&w=300&q=80" alt="Pizza Palace" />
        <h3>Pizza Palace</h3>
        <div class="restaurant-details">Italian, Pizza</div>
        <div>⭐ 4.3 &middot; 0.8 km</div>
      </div>
      <!-- Add more restaurant cards here -->
    </div>

    <!-- Menu Section (hidden by default, shown when restaurant is clicked) -->
    <div class="menu-section" id="menu-section" style="display:none;">
      <button onclick="closeMenu()" style="margin-bottom:17px;">← Back to Restaurants</button>
      <h2 id="menu-title"></h2>
      <div class="menu-list" id="menu-list"></div>
    </div>
  </div>

  <!-- CART Modal -->
  <div class="modal-bg" id="cart-modal">
    <div class="modal">
      <span class="close-x" onclick="hideModal('cart-modal')">×</span>
      <h2>Your Cart</h2>
      <div id="cart-contents">
        <div>Your cart is empty.</div>
      </div>
      <div id="cart-total"></div>
      <button class="checkout-btn" onclick="checkout()">Place Order</button>
    </div>
  </div>

  <!-- OFFERS Modal -->
  <div class="modal-bg" id="offers-modal">
    <div class="modal">
      <span class="close-x" onclick="hideModal('offers-modal')">×</span>
      <h2>Exclusive Offers</h2>
      <ul class="offer-list">
        <li>🍕 20% OFF on all pizzas - Code: PIZZA20</li>
        <li>🍛 Flat ₹50 OFF on first order - Code: WELCOME50</li>
        <li>👭 Referral Offer: Invite a friend and both get ₹100!</li>
      </ul>
    </div>
  </div>

  <!-- AUTH Modal -->
  <div class="modal-bg" id="auth-modal">
    <div class="modal">
      <span class="close-x" onclick="hideModal('auth-modal')">×</span>
      <h2>Sign In / Sign Up</h2>
      <form class="auth-form" onsubmit="loginUser(event)">
        <input id="user-name" type="text" placeholder="Name" required />
        <input id="user-email" type="email" placeholder="Email" required />
        <button type="submit" class="checkout-btn" style="width:100%;">Sign In</button>
      </form>
    </div>
  </div>

  <footer>
    <div>© 2024 DSR Food Court · <a href="#">Privacy</a> · <a href="#">Terms</a></div>
    <div><a href="#">Facebook</a> · <a href="#">Instagram</a></div>
  </footer>

  <script>
    // Mock menu data
    const MENUS = {
      "Spice Kitchen": [
        {id:'1a', name:"Butter Chicken", price:250, veg:false, img:"https://images.unsplash.com/photo-1516685018646-5499d0a7c063?auto=format&fit=crop&w=300&q=80"},
        {id:'1b', name:"Paneer Tikka", price:180, veg:true, img:"https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=300&q=80"},
        {id:'1c', name:"Fried Rice", price:150, veg:true, img:"https://images.unsplash.com/photo-1519864600265-abb39516a52b?auto=format&fit=crop&w=300&q=80"}
      ],
      "Pizza Palace": [
        {id:'2a', name:"Margherita Pizza", price:220, veg:true, img:"https://images.unsplash.com/photo-1548365328-849c10b4b198?auto=format&fit=crop&w=300&q=80"},
        {id:'2b', name:"Pepperoni Pizza", price:270, veg:false, img:"https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=300&q=80"}
      ]
    };
    let CART = [];
    function showModal(id) {
      document.getElementById(id).classList.add('show');
      if (id === "cart-modal") showCart();
    }
    function hideModal(id) {
      document.getElementById(id).classList.remove('show');
    }
    function showMenu(resName) {
      document.querySelector('.restaurant-list').style.display = "none";
      document.getElementById('menu-section').style.display = "";
      document.getElementById('menu-title').innerText = resName;
      let menuDiv = document.getElementById('menu-list');
      menuDiv.innerHTML = "";
      (MENUS[resName] || []).forEach(dish => {
        menuDiv.innerHTML += `
          <div class='menu-card'>
            <img src='${dish.img}' alt='${dish.name}'>
            <div class="menu-info">
              <b>${dish.name}</b> <div>₹${dish.price}</div>
              <span class='veg-icon'>${dish.veg ? "🟢 Veg" : "🔴 Non-Veg"}</span>
              <br><button class='add-btn' onclick='event.stopPropagation();addToCart(${JSON.stringify(dish)})'>Add +</button>
            </div>
          </div>
        `;
      });
    }
    function closeMenu() {
      document.querySelector('.restaurant-list').style.display = "";
      document.getElementById('menu-section').style.display = "none";
      document.getElementById('menu-list').innerHTML = "";
    }
    function addToCart(dish) {
      let found = CART.find(i => i.id === dish.id);
      if (found) found.qty += 1; else CART.push({...dish, qty:1});
      showCart();
      updateCartCount();
    }
    function showCart() {
      let c = document.getElementById('cart-contents');
      let t = document.getElementById('cart-total');
      if (CART.length === 0) {
        c.innerHTML = "<div>Your cart is empty.</div>";
        t.innerHTML = "";
        return;
      }
      c.innerHTML = CART.map(item => `
        <div class='cart-item'>
          <span>${item.name}</span>
          <span>₹${item.price} × ${item.qty}</span>
          <button onclick="removeItem('${item.id}')">x</button>
        </div>
      `).join('');
      let total = CART.reduce((sum, i) => sum+i.price*i.qty, 0);
      t.innerHTML = `<div class='cart-total'>Total: ₹${total}</div>`;
    }
    function removeItem(id) {
      CART = CART.filter(item=>item.id !== id);
      showCart();
      updateCartCount();
    }
    function updateCartCount() {
      document.getElementById('cart-count').innerText = CART.length ? `(${CART.reduce((s,i)=>s+i.qty,0)})` : "";
    }
    function checkout() {
      alert("Thank you! Order placed 🚚");
      CART = [];
      showCart();
      updateCartCount();
      hideModal('cart-modal');
    }
    // Auth modal
    function loginUser(e) {
      e.preventDefault();
      let name = document.getElementById('user-name').value || "";
      let email = document.getElementById('user-email').value || "";
      alert("Welcome, " + name + "!");
      hideModal('auth-modal');
    }
    // For browser navigation
    window.onclick = function(e){
      if(e.target.classList.contains('modal-bg')) e.target.classList.remove('show');
    }
  </script>
</body>
</html>
