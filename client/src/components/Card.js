import '../scss/Card.scss';
import Model from './Model';
import Chart from './Chart';
import { useState } from 'react';
import APIService from '../services/APIService';
import Spinner from './Spinner';
import Error from './Error';

function Card({ card }) {
    const [histories, setHistories] = useState([]);
    const [isShowModel, setIsShowModel] = useState(false);
    const [isLoading, setIsLoading] = useState(true);
    const [isError, setIsError] = useState(false);


    const getDate = (days = 0) => {
        const date = new Date(Date.now() - (1000 * 60 * 60 * 24 * days))

        let year = date.getFullYear();
        let month = date.getMonth();
        let day = date.getDate();

        return `${year}-${month >= 9 ? month : `0${month}`}-${day >= 9 ? day : `0${day}`}`;
    }

    const getHistories = (start, end) => {
        APIService.getCoinHistories(card.short_name, start, end)
            .then((data) => {
                setIsError(false)
                setIsLoading(true)

                setHistories(data)
                
                setIsLoading(false)
            }).catch((error) => {
                setIsError(true)

                console.error(error)
            })
    }

    const handleSubmit = (event) => {
        const formData = new FormData(event.target);
        getHistories(
            formData.get('start'),
            formData.get('end')
        );

        event.preventDefault();
    }

    const openModel = () => {
        setIsShowModel(true);
        getHistories(
            getDate(30), // Minus 30 days
            getDate() // today
        );
    }

    const closeModel = () => {
        setIsShowModel(false);
    }

    const chart = isLoading && histories
        ? <Spinner />
        : isError ? <Error message={"Something went wrong!"} /> : <Chart histories={histories} />

    const model = isShowModel
        ? <Model id={card.short_name} title={card.full_name} handleClose={closeModel}>
            <div className='card-chart'>
                <div className='card-chart-form'>
                    <form onSubmit={handleSubmit}>
                        <label>From:
                            <input type='date' defaultValue={getDate(30)} name='start' max={getDate()} required />
                        </label>

                        <label>To:
                            <input type='date' defaultValue={getDate()} name='end' max={getDate()} required />
                        </label>

                        <input type='submit' className='btn' value='Send' />
                    </form>
                </div>
                <div className='card-chart-graph'>
                    {chart}
                </div>
            </div>
        </Model>
        : null

    return (
        <article className="card">
            {model}
            <h2 className="card-title">{card.full_name}</h2>
            <div className="card-image"><img src={card.icon_url} alt="logo" /></div>
            <div className="card-body">
                <p><b>Rank:</b> {card.rank}</p>
                <p><b>Change:</b> {card.change_24h}</p>
                <p><b>Market cap:</b> {card.market_cap}</p>
                <p><b>Price:</b> {card.price}</p>
                <p><b>Symbol:</b> {card.symbol}</p>
            </div>
            <button className="card-button btn" onClick={openModel}>Read more</button>
        </article>
    );
}


export default Card;