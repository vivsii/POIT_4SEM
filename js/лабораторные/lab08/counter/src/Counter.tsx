import React from 'react';
import Button from "./Button";
import {useState} from "react";
import styles from "./Counter.module.css"
import './counter.css'
import './input'
import INPUT from "./input";
import List from "./List";

function Counter() {
    const [count, setCount] = useState(0)
    const[inputText, setINputText] = useState('');
    const [text, setText] = useState("")
    const increaseCount = () => {
        setCount(count + 1);
    };
    const resetCount = () => {
        setCount(0);
    };
    const inputChange=(event: React.ChangeEvent<HTMLInputElement>)=>{
        setINputText(event.target.value)
    }
    return(
        <div className={styles.counterContainer}>
            <h1 className={count === 5 ? styles.redNum: ''}>{count}</h1>
            <Button title="increase" onClick={increaseCount} disabled={count >= 5} className={"increase"}/>
            <Button title="reset" onClick={resetCount} disabled={count === 0} className={"reset"}/>
            <INPUT onChange={inputChange} value={inputText} text={text}/>
            <Button title={"отобразить"} onClick={() => setText(inputText)}/>
            <div>
                <List/>
            </div>
        </div>
    )
}
export default Counter;