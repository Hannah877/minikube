import { useState, useEffect } from 'react';
import styles from '../styles/Table.module.css';

export default function Table() {
  const [customers, setCustomers] = useState([]);

  useEffect(() => {
    fetch('http://localhost:8080/table')
      .then(response => response.json())
      .then(data => setCustomers(data))
      .catch(error => console.error("Failed to load customer data:", error));
  }, []);

  return (
    <div className={styles.container}>
      <h1>Canadian Customers</h1>
      <table className={styles.table}>
        <thead>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>City</th>
          </tr>
        </thead>
        <tbody>
          {customers.map((customer, index) => (
            <tr key={index}>
              <td>{customer.first_name}</td>
              <td>{customer.last_name}</td>
              <td>{customer.email}</td>
              <td>{customer.city}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
