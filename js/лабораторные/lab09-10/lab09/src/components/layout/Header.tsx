import React from 'react';

type HeaderProps = {
  onClick: () => void
};

export const Header = (props: HeaderProps) => {
  return (
    <header>
      <button className="newGameButton" onClick={props.onClick}>
        New Game
      </button>
    </header>
  )
}
