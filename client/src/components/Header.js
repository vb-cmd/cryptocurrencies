import { useRef } from "react";
import "../scss/Header.scss";

// const changeHeightHeader = () => {
//     const header = document.querySelector('#header');
//     header.style.height = `${window.innerHeight}px`;
// }

// window.onload = changeHeightHeader
// window.onresize = changeHeightHeader


function Header({ handleSearch }) {
    const inputSearch = useRef()

    const handleResaltSearch = () => {
        const value = inputSearch.current.value;

        handleSearch(value);

        document.getElementById("content")
            .scrollIntoView();
    }

    return (
        <header id="header">
            <div className="logo">
                cryptocurrencies
            </div>
            <div className="search">
                <input type="search" className="search-input" placeholder="Search ..." ref={inputSearch} />
                <input type="submit" value="Search" onClick={handleResaltSearch} className="search-submit" />
            </div>
            <div className="intro">Some <a href="/">Link</a> intro</div>
        </header>
    );
}

export default Header;