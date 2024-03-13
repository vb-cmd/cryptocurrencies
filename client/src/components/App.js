import { useState, useEffect } from 'react';
import Content from './Content';
import Navigation from './Navigation';
import Footer from './Footer';
import Header from './Header';
import MoreButton from './MoreButton';
import Card from './Card';
import APIService from '../services/APIService';
import Spinner from './Spinner';
import Error from './Error';

export default function App() {
  const [coins, setCoins] = useState([]);
  const [cards, setCards] = useState([]);
  const [page, setPage] = useState(0);
  const [perPage, setPerPage] = useState(50);
  const [isLoading, setIsLoading] = useState(true);
  const [isError, setIsError] = useState(false);
  const [isDone, setIsDone] = useState(false);

  const handleSearch = (value) => {
    let filterData = coins.filter(coin => coin.full_name.toLowerCase().includes(value.toLowerCase()));
    
    setIsDone(value !== "")
    setCards(filterData)
  }

  const handleGetContent = () => {
    APIService.getCoins(page, perPage).then((data) => {
      setIsError(false);
      setIsLoading(true);

      const concatArray = coins.concat(data);
      setCoins(concatArray);
      setCards(concatArray);

      if (data.length === 0) {
        setIsDone(true);
      }

      setPage((p) => p + 1);

      setIsLoading(false);
    }).catch((error) => {

      setIsError(true);
    })
  }


  useEffect(() => {
    handleGetContent()
  }, []);


  const showContent = isLoading
    ? <Spinner />
    : <Content>
      {cards ? cards.map((card, index) => <Card key={"card-".concat(index)} card={card} />) : null}
    </Content>

  const showMoreButton = isDone
    ? null
    : <MoreButton handleClick={handleGetContent} />

  const showError = isError
    ? <Error message="Something went wrong" />
    : null

  return (
    <>
      <Navigation />
      <Header handleSearch={handleSearch} />
      {showContent}
      {showError}
      {showMoreButton}
      <Footer />
    </>
  );
}
