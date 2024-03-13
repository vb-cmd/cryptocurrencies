import '../scss/Error.scss';

function Error({ message }) {
    return (
        <div className="container-error">
            <p>{message}</p>
        </div>
    );
}

export default Error;