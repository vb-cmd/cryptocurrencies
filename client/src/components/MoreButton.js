import '../scss/MoreButton.scss';

export default function MoreButton({ handleClick }) {
    return (
        <div id="more-content">
            <button className='more-content-button btn' onClick={handleClick}>Show more</button>
        </div>
    );
}