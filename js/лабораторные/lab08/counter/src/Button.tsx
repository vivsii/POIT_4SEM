import React from 'react';

// Интерфейс для пропсов кнопки
interface ButtonProps {
    title: string;
    onClick?: (event: React.MouseEvent<HTMLButtonElement>) => void;
    disabled?: boolean;
    className?: string;
}

// Компонент кнопки
const Button: React.FC<ButtonProps> = ({ title, onClick, disabled,className }) => {
    const handleClick = (event: React.MouseEvent<HTMLButtonElement>) => {
        if (onClick) {
            onClick(event);
        }
    };
    return (
        <button onClick={handleClick} disabled={disabled} className={className}>
            {title}
        </button>
    );
};
export default Button;