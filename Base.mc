<%class>
has 'title' => (default => 'LVA-Review');
</%class>

<%augment wrap>
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/wae08/static/css/main.css">
    <script type="module" src="/wae08/static/js/main.js" defer></script>
    % $.Defer {{
      <title><% $.title %></title>
    % }}
  </head>
  <body>
    <dialog id="login-dialog">
      <form class="close" method="dialog">
        <button>×</button>
      </form>
      <form action="." method="POST">
        <h3>Login</h3>
        <p>
          Login into your account to rate and LVA pages.
        </p>
        <fieldset>
          <div>
            <label for="username">User</label>
            <input type="text" name="username" id="username" placeholder="your_account">
          </div>
          <div>
            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="●●●●●●●●">
          </div>
        </fieldset>
        <button>Login</button>
      </form>
    </dialog>
    <dialog id="logout-dialog">
      <form class="close" method="dialog">
        <button>×</button>
      </form>
      <form action="." method="POST">
        <h3>Logout</h3>
        <p>
          Do you want to logout from your account?
        </p>
        <button>Logout</button>
      </form>
    </dialog>
    <header>
      <figure>
        <a href="/">
          <img src="/wae08/static/images/logo.svg" alt="">
        </a>
        <figcaption>
          <h1>
            LVA-Review
          </h1>
        </figcaption>
      </figure>
      <nav>
        <ul>
          <li><a href="./modules/electives">Electives</a></li>
          <li><a href="./modules/sw-engineering">SW Engineering</a></li>
          <li><a href="./modules/mathematics">Mathematics</a></li>
          <li><a href="./modules/info-engineering">Info Engineering</a></li>
          <li><a href="./modules/society">Society</a></li>
          <li><a href="./modules/computer-systems">Computer Systems</a></li>
          <li>
            <a href="./modules/algorithms">Algorithms</a>
            <div class="popup">
              <nav>
                <ul>
                  <li>
                    <a href="kek.com" title="183.123 LVA 1">LVA 1</a>
                  </li>
                  <li>
                    <a href="kek.com" title="183.123 LVA with long name">LVA with long name</a>
                  </li>
                  <li>
                    <a href="kek.com" title="183.234 LVA with very very long name">LVA with very very long name</a>
                  </li>
                  <li>
                    <a href="kek.com" title="183.345 short LVA">short LVA</a>
                  </li>
                </ul>
              </nav>
            </div>
          </li>
        </ul>
      </nav>
      <div class="profile">
        <button id="profile-button">
          <img src="/wae08/static/images/key.svg" alt="">
        </button>
      </div>
    </header>
    <div class="page">
      <main>
        <% inner() %>
      </main>
      <aside>
        <nav>
          <h2>Newest</h2>
          <ol>
            <li>
              <a href="https://orf.at">Algorithmen und Datenstrukturen</a>
            </li>
            <li>
              <a href="">Algorithmen und Datenstrukturen</a>
            </li>
            <li>
              <a href="">Algorithmen und Datenstrukturen</a>
            </li>
            <li>
              <a href="">Algorithmen und Datenstrukturen</a>
            </li>
          </ol>
        </nav>
      </aside>
    </div>
    <footer>
      <section class="logo">
        <img src="/wae08/static/images/logo.svg" alt="">
        <span>Powered by Perl & Pain ♥</span>
      </section>
      <section class="info">
        <p>
          Submission for group WAE08
        </p>
        <p>
          WS 2023
        </p>
      </section>
      <section>
        <nav>
          <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/legal">Legal</a></li>
          </ul>
        </nav>
      </section>
      <section>
        <nav>
          <ul>
            <li><a href="./modules/electives">Electives</a></li>
            <li><a href="./modules/sw-engineering">SW Engineering</a></li>
            <li><a href="./modules/mathematics">Mathematics</a></li>
            <li><a href="./modules/info-engineering">Info Engineering</a></li>
            <li><a href="./modules/society">Society</a></li>
            <li><a href="./modules/computer-systems">Computer Systems</a></li>
            <li><a href="./modules/algorithms">Algorithms</a></li>
          </ul>
        </nav>
      </section>
      <section>
        <nav>
          <ul class="socials">
            <li>
              <a href="https://instagram.com">
                <img src="/wae08/static/images/instagram.webp"> Instagram
              </a>
            </li>
            <li>
              <a href="https://facebook.com">
                <img src="/wae08/static/images/facebook.webp"> Facebook
              </a>
            </li>
            <li>
              <a href="https://twitter.com">
                <img src="/wae08/static/images/twitter.webp"> Twitter
              </a>
            </li>
          </ul>
        </nav>
      </section>
    </footer>
  </body>
  </html>
</%augment>

<%flags>
extends => undef
</%flags>
