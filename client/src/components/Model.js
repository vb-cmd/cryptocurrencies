import '../scss/Model.scss';

function Model({ id, title, handleClose, children }) {
    return (
        <div className="model" id={"model-".concat(id)}>
            <div className="model-content">
                <h2 className="model-title">{title}</h2>
                <div className="model-body">
                { children }
                </div>
                <button className="model-close btn" onClick={handleClose}>Close</button>
            </div>
        </div>
    );
}

export default Model;