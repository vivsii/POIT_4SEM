import React from "react";

interface InputProps {
    onChange: (event: React.ChangeEvent<HTMLInputElement>) => void;
    value?: string;
    text?: string;
}
const INPUT: React.FC<InputProps> = ({ onChange, value, text}) => {
    return (
        <div>
            <h2>{text}</h2>
            <input onChange={onChange} value={value}/>
        </div>
    );
};
export default INPUT