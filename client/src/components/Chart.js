import { CChart } from '@coreui/react-chartjs'

export default function Chart({histories}) {
    return (
        <CChart
            type="bar"
            data={{
                labels: histories ? histories.map((item) => item.date) : [],
                datasets: [
                    {
                        label: 'Price',
                        backgroundColor: '#f87979',
                        data: histories ? histories.map((item) => item.price) : [],
                    },
                ],
            }}
            labels="days"
            options={{
                plugins: {
                    legend: {
                        labels: {
                            color: '#fff',
                        }
                    }
                },
                scales: {
                    x: {
                        grid: {
                            color: '#ed203d',
                        },
                        ticks: {
                            color: '#ed203d',
                        },
                    },
                    y: {
                        grid: {
                            color: '#fff',
                        },
                        ticks: {
                            color: '#fff',
                        },
                    },
                },
            }}
        />);
}