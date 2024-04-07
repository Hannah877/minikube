import Link from 'next/link';
import styles from '../styles/Home.module.css';

export default function Home() {
  return (
    <div className={styles.container}>
      <h1>Please Click the link below to see the table</h1>
      <Link href="/table">
        View Canadian Customers
      </Link>
    </div>
  );
}
