<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" data-theme="dark">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ config('app.name', 'Gamer Tag') }}</title>
  @if (file_exists(public_path('build/manifest.json')) || file_exists(public_path('hot')))
    @vite(['resources/css/app.css', 'resources/js/app.js'])
  @endif
</head>
<body>
  <nav class="navbar is-fixed-top" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item has-text-weight-bold" href="#">
        {{ config('app.name', 'GamerTag') }}
      </a>
      <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarMenu">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>
    <div id="navbarMenu" class="navbar-menu">
      <div class="navbar-end">
        <a class="navbar-item" href="#who">Who I Am</a>
        <a class="navbar-item" href="#where">Where I Live</a>
        <a class="navbar-item" href="#games">Favorite Games</a>
        <a class="navbar-item" href="#stats">Stats</a>
        <a class="navbar-item" href="#setup">Setup</a>
        <a class="navbar-item" href="#contact">Contact</a>
        <div class="navbar-item">
          <button class="button is-small" id="themeToggle" aria-label="Toggle theme">🌙</button>
        </div>
      </div>
    </div>
  </nav>

  <section class="hero is-fullheight-with-navbar is-dark">
    <div class="hero-body">
      <div class="container has-text-centered">
        <p class="is-size-1 has-text-weight-bold">Level Up</p>
        <p class="subtitle is-size-4 mt-2">Welcome to my gaming realm</p>
      </div>
    </div>
  </section>

  <section id="who" class="section">
    <div class="container">
      <h2 class="title is-2 has-text-centered">Who I Am</h2>
      <div class="columns is-vcentered is-centered mt-5">
        <div class="column is-narrow">
          <figure class="image is-256x256">
            <img class="is-rounded" src="https://bulma.io/assets/images/placeholders/256x256.png" alt="Avatar">
          </figure>
        </div>
        <div class="column is-half">
          <p class="is-size-5">
            Hey there! I'm <strong>{{ config('app.name', 'PixelWarrior') }}</strong>, a passionate gamer
            who lives and breathes video games. By day I write code, by night I raid dungeons.
            I've been gaming since the NES era and I'm always down for a co-op session or a
            friendly 1v1. GG WP!
          </p>
        </div>
      </div>
    </div>
  </section>

  <section id="where" class="section has-background-light">
    <div class="container">
      <h2 class="title is-2 has-text-centered">Where I Live</h2>
      <div class="columns is-centered mt-5">
        <div class="column is-half has-text-centered">
          <span class="icon is-large">
            <i class="fas fa-map-marker-alt fa-3x"></i>
          </span>
          <p class="is-size-4 mt-3"><strong>Tokyo, Japan</strong></p>
          <p class="is-size-5 mt-2">Timezone: JST (UTC+9)</p>
          <p class="is-size-5">Active hours: 20:00 – 02:00 JST</p>
        </div>
      </div>
    </div>
  </section>

  <section id="games" class="section">
    <div class="container">
      <h2 class="title is-2 has-text-centered">Favorite Games</h2>
      <div class="columns is-multiline is-centered mt-5">
        <div class="column is-one-quarter">
          <div class="card">
            <div class="card-image">
              <figure class="image is-4by3">
                <img src="https://bulma.io/assets/images/placeholders/640x480.png" alt="Game 1">
              </figure>
            </div>
            <div class="card-content">
              <p class="title is-4">Elden Ring</p>
              <p class="subtitle is-6">Open-world RPG</p>
              <p class="is-size-7">Tarnished, rise. Hundreds of hours and still finding secrets.</p>
            </div>
          </div>
        </div>
        <div class="column is-one-quarter">
          <div class="card">
            <div class="card-image">
              <figure class="image is-4by3">
                <img src="https://bulma.io/assets/images/placeholders/640x480.png" alt="Game 2">
              </figure>
            </div>
            <div class="card-content">
              <p class="title is-4">The Witcher 3</p>
              <p class="subtitle is-6">Action RPG</p>
              <p class="is-size-7">Geralt's journey through the Continent. Best story ever told.</p>
            </div>
          </div>
        </div>
        <div class="column is-one-quarter">
          <div class="card">
            <div class="card-image">
              <figure class="image is-4by3">
                <img src="https://bulma.io/assets/images/placeholders/640x480.png" alt="Game 3">
              </figure>
            </div>
            <div class="card-content">
              <p class="title is-4">Valorant</p>
              <p class="subtitle is-6">Tactical FPS</p>
              <p class="is-size-7">Ranked grind never stops. Main: Jett / Phoenix.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="stats" class="section has-background-light">
    <div class="container">
      <h2 class="title is-2 has-text-centered">Game Stats</h2>
      <div class="columns is-centered mt-5">
        <div class="column is-two-thirds">
          <div class="table-container">
            <table class="table is-striped is-fullwidth is-hoverable">
              <thead>
                <tr>
                  <th>Game</th>
                  <th>Hours Played</th>
                  <th>Achievements</th>
                  <th>Skill Level</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Elden Ring</td>
                  <td>340</td>
                  <td>42 / 42</td>
                  <td><progress class="progress is-success is-small" value="95" max="100">95%</progress></td>
                </tr>
                <tr>
                  <td>The Witcher 3</td>
                  <td>210</td>
                  <td>68 / 78</td>
                  <td><progress class="progress is-primary is-small" value="85" max="100">85%</progress></td>
                </tr>
                <tr>
                  <td>Valorant</td>
                  <td>500</td>
                  <td>—</td>
                  <td><progress class="progress is-link is-small" value="70" max="100">70%</progress></td>
                </tr>
                <tr>
                  <td>Celeste</td>
                  <td>80</td>
                  <td>30 / 30</td>
                  <td><progress class="progress is-warning is-small" value="100" max="100">100%</progress></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="setup" class="section">
    <div class="container">
      <h2 class="title is-2 has-text-centered">Gaming Setup</h2>
      <div class="columns mt-5">
        <div class="column is-half">
          <h3 class="title is-4">Hardware</h3>
          <ol class="ml-4">
            <li>CPU: AMD Ryzen 7 7800X3D</li>
            <li>GPU: NVIDIA RTX 4080</li>
            <li>RAM: 32 GB DDR5</li>
            <li>Monitor: LG 27" 240Hz OLED</li>
            <li>Headset: HyperX Cloud Alpha</li>
          </ol>
        </div>
        <div class="column is-half">
          <h3 class="title is-4">Top 5 Games of All Time</h3>
          <ul class="ml-4">
            <li>The Witcher 3: Wild Hunt</li>
            <li>Elden Ring</li>
            <li>Chrono Trigger</li>
            <li>The Legend of Zelda: Breath of the Wild</li>
            <li>Red Dead Redemption 2</li>
          </ul>
        </div>
      </div>

      <div class="columns mt-5">
        <div class="column is-half">
          <h3 class="title is-4">Latest Screenshot</h3>
          <figure class="image is-16by9">
            <img src="https://bulma.io/assets/images/placeholders/1280x720.png" alt="Elden Ring screenshot">
          </figure>
          <figcaption class="has-text-centered mt-2 is-size-7 has-text-grey">
            Exploring Caelid — <em>Elden Ring</em>
          </figcaption>
        </div>
        <div class="column is-half">
          <h3 class="title is-4">Live Stream</h3>
          <div class="has-ratio" style="position:relative;padding-bottom:56.25%">
            <iframe
              style="position:absolute;top:0;left:0;width:100%;height:100%"
              src="https://www.youtube.com/embed/dQw4w9WgXcQ"
              title="Stream highlight"
              allowfullscreen
            ></iframe>
          </div>
          <p class="is-size-7 has-text-grey mt-1">Watch me play live on Twitch!</p>
        </div>
      </div>

      <div class="columns mt-5">
        <div class="column is-half">
          <h3 class="title is-4">Game Reviews</h3>
          <details class="box">
            <summary class="has-text-weight-bold">Elden Ring — ★★★★★</summary>
            <p class="mt-2">A masterpiece of open-world design. Every corner hides a secret, every boss is a challenge you'll remember. 10/10 would get lost again.</p>
          </details>
          <details class="box mt-2">
            <summary class="has-text-weight-bold">Valorant — ★★★★☆</summary>
            <p class="mt-2">Tactical shooter with deep agent abilities. Great with friends, frustrating solo. The ranked grind is real but rewarding.</p>
          </details>
        </div>
        <div class="column is-half">
          <h3 class="title is-4">Gaming Skills</h3>
          <div class="field">
            <label class="label">Reaction Time</label>
            <progress class="progress is-danger" value="90" max="100">90%</progress>
          </div>
          <div class="field">
            <label class="label">Map Awareness</label>
            <progress class="progress is-warning" value="75" max="100">75%</progress>
          </div>
          <div class="field">
            <label class="label">Team Coordination</label>
            <progress class="progress is-success" value="85" max="100">85%</progress>
          </div>
          <div class="field">
            <label class="label">Speedrunning</label>
            <progress class="progress is-info" value="45" max="100">45%</progress>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="contact" class="section has-background-light">
    <div class="container">
      <h2 class="title is-2 has-text-centered">Contact Me</h2>
      <p class="subtitle is-5 has-text-centered">Let's team up!</p>
      <div class="columns is-centered mt-5">
        <div class="column is-half">
          <div class="buttons is-centered are-medium mb-5">
            <a class="button is-info" href="#">Discord</a>
            <a class="button is-dark" href="#">Steam</a>
            <a class="button is-black" href="#">Twitch</a>
          </div>
        </div>
      </div>

      <div class="columns is-centered">
        <div class="column is-half">
          <form action="#" method="post">
            <div class="field">
              <label class="label" for="name">Name</label>
              <div class="control">
                <input class="input" id="name" name="name" type="text" placeholder="Your gamer tag">
              </div>
            </div>
            <div class="field">
              <label class="label" for="email">Email</label>
              <div class="control">
                <input class="input" id="email" name="email" type="email" placeholder="you@example.com">
              </div>
            </div>
            <div class="field">
              <label class="label" for="game">Favorite Game</label>
              <div class="control">
                <div class="select is-fullwidth">
                  <select id="game" name="game">
                    <option>Elden Ring</option>
                    <option>The Witcher 3</option>
                    <option>Valorant</option>
                    <option>Celeste</option>
                    <option>Other</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="field">
              <label class="label" for="message">Message</label>
              <div class="control">
                <textarea class="textarea" id="message" name="message" placeholder="Let's play together!"></textarea>
              </div>
            </div>
            <div class="field">
              <div class="control">
                <button class="button is-primary is-fullwidth" type="submit">Send Message</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>

  <footer class="footer has-background-dark has-text-white">
    <div class="content has-text-centered">
      <p>&copy; {{ date('Y') }} {{ config('app.name', 'GamerTag') }}. No rage quits.</p>
      @if (commit_hash())
        <p class="is-size-7 mt-1 has-text-grey-light">dev {{ commit_hash() }}</p>
      @endif
    </div>
  </footer>

  <script>
    document.addEventListener('DOMContentLoaded', () => {
      const burger = document.querySelector('.navbar-burger');
      const menu = document.querySelector('.navbar-menu');
      if (burger && menu) {
        burger.addEventListener('click', () => {
          burger.classList.toggle('is-active');
          menu.classList.toggle('is-active');
        });
      }

      const html = document.documentElement;
      const toggle = document.getElementById('themeToggle');

      function setTheme(theme) {
        html.setAttribute('data-theme', theme);
        toggle.textContent = theme === 'dark' ? '🌙' : '☀️';
        localStorage.setItem('theme', theme);
      }

      const saved = localStorage.getItem('theme');
      if (saved) {
        html.setAttribute('data-theme', saved);
        toggle.textContent = saved === 'dark' ? '🌙' : '☀️';
      }

      toggle.addEventListener('click', () => {
        const current = html.getAttribute('data-theme');
        setTheme(current === 'dark' ? 'light' : 'dark');
      });
    });
  </script>
</body>
</html>
