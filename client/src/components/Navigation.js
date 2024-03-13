import '../scss/Navigation.scss';

export default function Navigation() {
    return (
        <menu className="menu-navigation">
            <a href="#header" className="link">Search</a>
            <a href="#content" className="link">Cryptocurrencies</a>
            <a href="#footer" className="link">About</a>
        </menu>
    );
}