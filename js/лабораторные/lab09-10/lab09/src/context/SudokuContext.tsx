import React, { createContext, useContext, useState } from 'react';
import moment from 'moment';

type SudokuContextProps = {
  numberSelected: string,
  setNumberSelected: React.Dispatch<React.SetStateAction<string>>,
  gameArray: string[],
  setGameArray: React.Dispatch<React.SetStateAction<string[]>>,
  difficulty: string,
  setDifficulty: React.Dispatch<React.SetStateAction<string>>,
  timeGameStarted: moment.Moment,
  setTimeGameStarted: React.Dispatch<React.SetStateAction<moment.Moment>>,
  fastMode: boolean,
  setFastMode: React.Dispatch<React.SetStateAction<boolean>>,
  cellSelected: number,
  cellError: number[],
  setCellSelected: React.Dispatch<React.SetStateAction<number>>,
  setCellError:React.Dispatch<React.SetStateAction<number[]>>,
  initArray: string[],
  setInitArray: React.Dispatch<React.SetStateAction<string[]>>,
  won: boolean,
  setWon: React.Dispatch<React.SetStateAction<boolean>>,
  showError: boolean, setShowError:React.Dispatch<React.SetStateAction<boolean>>
};


const SudokuContext = createContext<SudokuContextProps>({
                                                          numberSelected: '0', setNumberSelected: () => {},
                                                          gameArray: [], setGameArray: () => {},
                                                          difficulty: 'Easy', setDifficulty: () => {},
                                                          timeGameStarted: moment(), setTimeGameStarted: () => {},
                                                          fastMode: false, setFastMode: () => {},
                                                          cellSelected: -1, setCellSelected: () => {},
                                                          cellError: [], setCellError: () => {},
                                                          initArray: [], setInitArray: () => {},
                                                          won: false, setWon: () => {},
                                                          showError: false, setShowError: () => {}
});

type SudokuProviderProps = {
  children: React.ReactElement
};

export const SudokuProvider = ({ children }: SudokuProviderProps) => {
  let [ numberSelected, setNumberSelected ] = useState<string>('0');
  let [ gameArray, setGameArray ] = useState<string[]>([]);
  let [ difficulty,setDifficulty ] = useState<string>('inhuman');
  let [ timeGameStarted, setTimeGameStarted ] = useState<moment.Moment>(moment());
  let [ fastMode, setFastMode ] = useState<boolean>(false);
  let [ cellSelected, setCellSelected ] = useState<number>(-1);
  let [cellError, setCellError] = useState<number[]>([]);
  let [ initArray, setInitArray ] = useState<string[]>([]);
  let [ won, setWon ] = useState<boolean>(false);
  let [showError, setShowError] = useState(false);

  return (
    <SudokuContext.Provider value={
      {
        numberSelected, setNumberSelected,
        gameArray, setGameArray,
        difficulty,setDifficulty,
        timeGameStarted, setTimeGameStarted,
        fastMode, setFastMode,
        cellSelected, setCellSelected,
        initArray, setInitArray,
        won, setWon,
        cellError, setCellError,
        showError, setShowError
      }
    }>
      {children}
    </SudokuContext.Provider>
  );
};

export const useSudokuContext = (): SudokuContextProps => useContext(SudokuContext);

