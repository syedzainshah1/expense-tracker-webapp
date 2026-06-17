<!DOCTYPE html>
<html>
<head>
    <title>Login & Register</title>

    <!-- CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>

<div class="container" id="container">

    <!-- LEFT SIDE FORMS -->
    <div class="forms-container">

        <!-- LOGIN -->
        <div class="form-container sign-in-container">

            <form action="<%=request.getContextPath()%>/login"
                  method="post">

                <h2>Sign In</h2>

                <%
                    String error = request.getParameter("error");
                    if ("invalid".equals(error)) {
                %>
                <p style="color:red;">Invalid Email or Password</p>
                <%
                    }
                %>

                <div class="input-box">
                    <i class="fa fa-envelope"></i>
                    <input type="email"
                           name="email"
                           placeholder="Email Address"
                           required>
                </div>

                <div class="input-box">
                    <i class="fa fa-lock"></i>
                    <input type="password"
                           name="password"
                           placeholder="Password"
                           required>
                </div>

                <a href="#" class="forgot">Forgot Password?</a>

                <button type="submit">Sign In</button>

                <p class="social-text">Or Sign In With</p>

                <div class="social-icons">
                    <a href="#"><i class="fab fa-google"></i></a>
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>

            </form>

        </div>

        <!-- REGISTER -->
        <div class="form-container sign-up-container">

            <form action="register" method="post">

                <h2>Create Account</h2>

                <div class="input-box">
                    <i class="fa fa-user"></i>
                    <input type="text"
                           name="name"
                           placeholder="Full Name"
                           required>
                </div>

                <div class="input-box">
                    <i class="fa fa-envelope"></i>
                    <input type="email"
                           name="email"
                           placeholder="Email Address"
                           required>
                </div>

                <div class="input-box">
                    <i class="fa fa-lock"></i>
                    <input type="password"
                           name="password"
                           placeholder="Password"
                           required>
                </div>

                <button type="submit">Sign Up</button>

                <p class="social-text">Or Register With</p>

                <div class="social-icons">
                    <a href="#"><i class="fab fa-google"></i></a>
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>

            </form>

        </div>

    </div>

    <!-- RIGHT SIDE PANEL -->
    <div class="overlay-container">

        <div class="overlay">

            <!-- LEFT PANEL -->
            <div class="overlay-panel overlay-left">

                <h2>Welcome Back!</h2>

                <p>
                    To keep connected with us,
                    please login with your personal info
                </p>

                <button class="ghost" id="signIn">
                    Sign In
                </button>
                <p style="margin-top:15px;">
                    Don't have an account?
                </p>



            </div>

            <!-- RIGHT PANEL -->
            <div class="overlay-panel overlay-right">

                <h2>Hello, Friend!</h2>

                <p>
                    Enter your personal details
                    and start your journey with us
                </p>

                <button class="ghost" id="signUp">Sign Up</button>



            </div>

        </div>

    </div>

</div>

<script>

    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });

</script>

</body>
</html>