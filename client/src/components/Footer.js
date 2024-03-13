import '../scss/Footer.scss';

function Footer() {
    return (
        <footer id="footer">
            <a className="logo" href="#header">cryptocurrencies</a>
            <nav className="social">
                <a href="/">Facebook</a>
                <a href="/">Instagram</a>
                <a href="/">Telegram</a>
                <a href="/">Twitter</a>
            </nav>
            <div className="copyright">Made with love</div>
        </footer>
    );
}

export default Footer;