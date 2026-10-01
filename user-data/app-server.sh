#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

echo "Starting portfolio setup user-data script..."

# Wait for network interface initialization
sleep 5

# Install Nginx with retries
for i in {1..5}; do
  dnf install -y nginx && break || sleep 5
done

# Create lightweight, high-performance portfolio index.html (< 5KB)
cat << 'EOF' > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Venkateshwarlu Musku | Portfolio</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg: #0b0f19; --card: #111827; --border: rgba(255,255,255,0.08);
            --primary: #6366f1; --accent: #06b6d4; --text: #f9fafb; --muted: #9ca3af;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; scroll-behavior: smooth; }
        body { background: var(--bg); color: var(--text); font-family: 'Plus Jakarta Sans', sans-serif; line-height: 1.6; }
        nav { position: fixed; top: 0; width: 100%; z-index: 100; background: rgba(11,15,25,0.85); backdrop-filter: blur(12px); border-bottom: 1px solid var(--border); padding: 1rem 2rem; }
        .nav-inner { max-width: 1100px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-weight: 800; font-size: 1.2rem; background: linear-gradient(135deg, var(--primary), var(--accent)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-links a { color: var(--muted); text-decoration: none; margin-left: 1.5rem; font-size: 0.9rem; font-weight: 500; }
        .nav-links a:hover { color: var(--primary); }
        .hero { min-height: 90vh; display: flex; align-items: center; padding: 7rem 2rem 4rem; max-width: 1100px; margin: 0 auto; }
        .badge { display: inline-block; padding: 0.3rem 0.8rem; background: rgba(99,102,241,0.12); border: 1px solid rgba(99,102,241,0.3); border-radius: 50px; color: #818cf8; font-size: 0.85rem; margin-bottom: 1rem; }
        h1 { font-size: 3rem; font-weight: 800; line-height: 1.2; margin-bottom: 1rem; }
        h1 span { background: linear-gradient(135deg, #a5b4fc, #38bdf8); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .subtitle { font-size: 1.2rem; color: var(--muted); margin-bottom: 1.5rem; }
        .desc { color: var(--muted); max-width: 650px; margin-bottom: 2rem; }
        .btn-group { display: flex; gap: 1rem; margin-bottom: 2rem; flex-wrap: wrap; }
        .btn { padding: 0.75rem 1.5rem; border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; font-size: 0.9rem; }
        .btn-p { background: linear-gradient(135deg, var(--primary), #4f46e5); color: #fff; }
        .btn-s { background: rgba(255,255,255,0.05); color: var(--text); border: 1px solid var(--border); }
        .btn:hover { opacity: 0.9; transform: translateY(-2px); }
        section { padding: 5rem 2rem; max-width: 1100px; margin: 0 auto; }
        .stitle { font-size: 2rem; font-weight: 700; margin-bottom: 2.5rem; text-align: center; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
        .card { background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 1.5rem; }
        .card:hover { border-color: rgba(99,102,241,0.4); }
        .card h3 { font-size: 1.1rem; margin-bottom: 0.8rem; color: #a5b4fc; }
        .tags { display: flex; flex-wrap: wrap; gap: 0.4rem; }
        .tag { padding: 0.25rem 0.6rem; background: rgba(255,255,255,0.04); border: 1px solid var(--border); border-radius: 4px; font-size: 0.8rem; color: var(--muted); }
        .timeline { border-left: 2px solid var(--border); padding-left: 1.5rem; margin-left: 0.5rem; }
        .t-item { margin-bottom: 2rem; position: relative; }
        .t-item::before { content:''; position: absolute; left: -1.95rem; top: 0.3rem; width: 10px; height: 10px; border-radius: 50%; background: var(--primary); }
        .t-company { color: var(--accent); font-weight: 600; }
        .t-role { font-size: 1.1rem; font-weight: 700; }
        .t-date { font-family: 'JetBrains Mono', monospace; font-size: 0.8rem; color: var(--muted); margin-bottom: 0.5rem; }
        .bullets { list-style-type: square; padding-left: 1.2rem; color: var(--muted); font-size: 0.9rem; }
        footer { border-top: 1px solid var(--border); padding: 3rem 2rem; text-align: center; color: var(--muted); font-size: 0.9rem; }
    </style>
</head>
<body>
    <nav>
        <div class="nav-inner">
            <div class="logo"><i class="fa-solid fa-code"></i> Venkateshwarlu Musku</div>
            <div class="nav-links">
                <a href="#about">About</a>
                <a href="#skills">Skills</a>
                <a href="#experience">Experience</a>
                <a href="#education">Education</a>
            </div>
        </div>
    </nav>

    <section class="hero" id="about">
        <div>
            <span class="badge"><i class="fa-solid fa-cloud"></i> AWS & Terraform Deployed</span>
            <h1>Venkateshwarlu <span>Musku</span></h1>
            <div class="subtitle">Full Stack Developer | Aspiring Cloud & DevOps Engineer</div>
            <p class="desc">3+ years of experience engineering scalable web applications using Laravel, Node.js, React, and Express. Active in automating 3-Tier cloud infrastructure on AWS using Terraform, Docker, and CI/CD pipelines.</p>
            <div class="btn-group">
                <a href="mailto:venkateshmusku6@gmail.com" class="btn btn-p"><i class="fa-solid fa-envelope"></i> Email Me</a>
                <a href="https://linkedin.com/in/venkateshwarlu-musku" target="_blank" class="btn btn-s"><i class="fa-brands fa-linkedin"></i> LinkedIn</a>
                <a href="https://github.com/muskuVenkatesh" target="_blank" class="btn btn-s"><i class="fa-brands fa-github"></i> GitHub</a>
            </div>
        </div>
    </section>

    <section id="skills">
        <h2 class="stitle">Technical Skills</h2>
        <div class="grid">
            <div class="card">
                <h3><i class="fa-brands fa-aws"></i> Cloud & DevOps</h3>
                <div class="tags">
                    <span class="tag">AWS (EC2, S3, IAM)</span><span class="tag">Terraform (IaC)</span><span class="tag">Docker</span><span class="tag">Kubernetes</span><span class="tag">Jenkins</span><span class="tag">GitHub Actions</span><span class="tag">Linux</span>
                </div>
            </div>
            <div class="card">
                <h3><i class="fa-solid fa-layer-group"></i> Full Stack Web</h3>
                <div class="tags">
                    <span class="tag">Laravel (PHP)</span><span class="tag">Node.js</span><span class="tag">Express.js</span><span class="tag">React.js</span><span class="tag">JavaScript</span><span class="tag">Python</span><span class="tag">HTML5/CSS3</span>
                </div>
            </div>
            <div class="card">
                <h3><i class="fa-solid fa-database"></i> Databases & Tools</h3>
                <div class="tags">
                    <span class="tag">MySQL</span><span class="tag">PostgreSQL</span><span class="tag">MongoDB</span><span class="tag">REST APIs</span><span class="tag">RBAC</span><span class="tag">Git / GitLab</span><span class="tag">Claude / Antigravity AI</span>
                </div>
            </div>
        </div>
    </section>

    <section id="experience">
        <h2 class="stitle">Professional Experience</h2>
        <div class="timeline">
            <div class="t-item">
                <div class="t-company">OyeLabs Technology Services</div>
                <div class="t-role">Associate Full Stack Developer</div>
                <div class="t-date">Oct 2025 – Jul 2026</div>
                <ul class="bullets">
                    <li>Engineered e-commerce platforms with catalog, pricing, inventory, and automated order pipelines.</li>
                    <li>Automated QuickBooks & Xero accounting integrations with Laravel cron schedulers.</li>
                    <li>Integrated Stripe and Razorpay subscription billing with secure signature webhooks.</li>
                </ul>
            </div>
            <div class="t-item">
                <div class="t-company">RJ Global Solutions</div>
                <div class="t-role">Associate Full Stack Developer (ERP)</div>
                <div class="t-date">May 2025 – Sep 2025</div>
                <ul class="bullets">
                    <li>Delivered enterprise ERP covering CRM, POS, HRM, and automated payroll approval workflows.</li>
                </ul>
            </div>
            <div class="t-item">
                <div class="t-company">SR EDU Technologies Pvt Ltd</div>
                <div class="t-role">Full Stack Developer</div>
                <div class="t-date">Nov 2023 – Feb 2025</div>
                <ul class="bullets">
                    <li>Deployed Learning Management Systems (LMS) on AWS EC2 with Node.js, Express, S3 & IAM controls.</li>
                </ul>
            </div>
            <div class="t-item">
                <div class="t-company">Coding Ninjas, Delhi</div>
                <div class="t-role">Teaching Assistant (MERN & Python/DSA)</div>
                <div class="t-date">Dec 2022 – Nov 2023</div>
                <ul class="bullets">
                    <li>Mentored 2,000+ students on Data Structures, Algorithms, Python, and MERN Full Stack development.</li>
                </ul>
            </div>
        </div>
    </section>

    <section id="education">
        <h2 class="stitle">Education & Certifications</h2>
        <div class="grid">
            <div class="card">
                <h3>B.Tech in Mechanical Engineering</h3>
                <p style="color:var(--muted)">CMR Engineering College (2018 – 2022)</p>
                <p><strong>CGPA: 6.50</strong></p>
            </div>
            <div class="card">
                <h3>Intermediate (MPC)</h3>
                <p style="color:var(--muted)">Srinidhi Junior College (2016 – 2018)</p>
                <p><strong>CGPA: 7.4</strong></p>
            </div>
            <div class="card">
                <h3>Coding Certifications</h3>
                <p style="color:var(--muted)">Coding Ninjas</p>
                <ul class="bullets" style="margin-top:0.5rem;">
                    <li>Full Stack Development (MERN)</li>
                    <li>Python & Data Structures & Algorithms</li>
                </ul>
            </div>
        </div>
    </section>

    <footer>
        <p>Venkateshwarlu Musku | Full Stack Developer | <a href="mailto:venkateshmusku6@gmail.com" style="color:var(--primary)">venkateshmusku6@gmail.com</a></p>
        <p style="font-size:0.8rem; margin-top:0.5rem; color:#6b7280">Hosted on AWS EC2 & ALB via Terraform 3-Tier Architecture</p>
    </footer>
</body>
</html>
EOF

# Enable and start Nginx service
systemctl enable nginx
systemctl restart nginx

echo "Portfolio setup completed successfully."