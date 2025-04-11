import React, {useEffect, useState} from 'react';
import moment from 'moment';
import {Header} from './components/layout/Header';
import {GameSection} from './components/layout/GameSection';
import {StatusSection} from './components/layout/StatusSection';
import {getUniqueSudoku} from './solver/UniqueSudoku';
import {useSudokuContext} from './context/SudokuContext';
import {GlobalHotKeys} from "react-hotkeys";


export const Game: React.FC<{}> = () => {

  let { numberSelected, setNumberSelected,
        gameArray, setGameArray,
        difficulty,
        setTimeGameStarted,
        fastMode,
        cellSelected, setCellSelected,
        initArray, setInitArray,
        setWon,won, setCellError, cellError, setShowError } = useSudokuContext();
  let [ history, setHistory ] = useState<string[][]>([]);
  let [ solvedArray, setSolvedArray ] = useState<string[]>([]);
  let [ overlay, setOverlay ] = useState<boolean>(false);



  function _createNewGame(e?: React.ChangeEvent<HTMLSelectElement>) {
    let [ temporaryInitArray, temporarySolvedArray ] = getUniqueSudoku(difficulty, e);

    setInitArray(temporaryInitArray);
    setGameArray(temporaryInitArray);
    setSolvedArray(temporarySolvedArray);
    setNumberSelected('0');
    setCellSelected(-1);
    setCellError([]);
    setHistory([]);
    setWon(false);
  }



  function _isSolved(index: number, value: string) {
    if (gameArray.every((cell: string, cellIndex: number) => {
          if (cellIndex === index)
            return value === solvedArray[cellIndex];
          else
            return cell === solvedArray[cellIndex];
        })) {
      return true;
    }
    return false;
  }



  function _fillCell(index: number, value: string) {
    if (initArray[index] === '0') {

      let tempArray = gameArray.slice();
      let tempHistory = history.slice();

      tempHistory.push(gameArray.slice());
      setHistory(tempHistory);

      tempArray[index] = value;
      setGameArray(tempArray);

      if (_isSolved(index, value)) {
        setOverlay(true);
        setWon(true);
      }
    }
  }

  function getRow(row:number,field:string[]) {
    return  field.slice(row*9,row*9+9);
  }

  function checkForSame(elems:string[]){
    const zeros = elems.filter(x => Number(x)==0).length;
    if (zeros > 0) return new Set(elems).size + zeros - 1 < 9;
    return new Set(elems).size < 9;
  }

  function getCol(colIndex:number,field:string[]){
    return field.filter((_, index) => index % 9 === colIndex);
  }

  function getSquareIndexes(index:number){
    let indexesRow1:number[][] = [
      [0,1,2,9,10,11,18,19,20],
      [0,1,2,9,10,11,18,19,20],
      [0,1,2,9,10,11,18,19,20],
    ];
    indexesRow1 =indexesRow1.map((arr,index)=> arr.map(ell=>ell+3*index));

    let indexesRow2:number[][] = [
      [27,28,29,36,37,38,45,46,47],
      [27,28,29,36,37,38,45,46,47],
      [27,28,29,36,37,38,45,46,47]

    ];
    indexesRow2 = indexesRow2.map((arr,index)=> arr.map(ell=>ell+3*index))

    let indexesRow3:number[][] = [
      [54,55,56,63,64,65,72,73,74],
      [54,55,56,63,64,65,72,73,74],
      [54,55,56,63,64,65,72,73,74]

    ];
    indexesRow3 = indexesRow3.map((arr,index)=> arr.map(ell=>ell+3*index))

    const indexes = indexesRow1.concat(indexesRow2,indexesRow3);
    return indexes[index];
  }

  function getSquare(index:number,field:string[]){
    const indexes = getSquareIndexes(index);
    console.log(indexes);
    return field.filter((_,idx)=> indexes.includes(idx))
  }

  function _userFillCell(index: number, value: string) {
        _fillCell(index, value);
        addError(index, value);
  }

  function fillRow(row:number){
    let rowArr: number[] = []
    for (let i = row*9;i< row*9+9;i++){
      rowArr.push(i);
    }
    return rowArr;
  }

  function fillCol(col:number){
    let colArr: number[] = []
    for (let i = 0;i<= 9;i++){
      colArr.push(i*9+col);
    }
    return colArr;
  }



  function addError(index:number, value: string){
    let field = gameArray.slice()
    field[index] = value;
    let errors:number[] = []
    for (let i = 0;i < 9;i++){
      if(checkForSame(getRow(i,field))){
         errors = errors.concat(fillRow(i));
      }
      if(checkForSame(getCol(i,field))){
        errors = errors.concat(fillCol(i));
      }
      if (checkForSame(getSquare(i,field))){
        errors = errors.concat(getSquareIndexes(i));
      }
    }
    errors = Array.from(new Set(errors));
    setCellError(errors);
  }

  function onClickNewGame() {
    _createNewGame();
  }
  function onClickCell(indexOfArray: number) {
    setCellSelected(indexOfArray);
    setShowError(true);
  }


  function onClickNumber(number: string) {
    if (fastMode) {
      setNumberSelected(number)
    } else if (cellSelected !== -1) {
      _userFillCell(cellSelected,number);
    }
  }


  function onClickErase() {
    if(cellSelected !== -1 && gameArray[cellSelected] !== '0') {
      _fillCell(cellSelected, '0');
    }
  }

  function onClickHint() {
    if (cellSelected !== -1) {
      _userFillCell(cellSelected, solvedArray[cellSelected]);
    }
  }

  function onClickOverlay() {
    setOverlay(false);
    _createNewGame();
  }

  useEffect(() => {
    _createNewGame();
  }, []);

  function checkValid(){
      const solved = solvedArray.toString() === gameArray.toString()
      if (solved){
        setOverlay(true);
        setWon(true);
      }else {
        setOverlay(true);
        setWon(false);
      }
  }


  const keyMap = {
    NEWGAME: "n",
    HINT: "h",
    CHECK: "c",
    ERRORS: "e"
  };

  const handlers = {
    NEWGAME: onClickNewGame,
    HINT: onClickHint,
    CHECK:checkValid,
    ERRORS: checkErrors
  };

  function checkErrors(){
      setShowError(true)
  }

  return (
      <GlobalHotKeys keyMap={keyMap} handlers={handlers} allowChanges={true} >
      <div className={overlay?"container blur":"container"}>
        <Header onClick={onClickNewGame}/>
        <div className="innercontainer">
          <GameSection
            onClick={(indexOfArray: number) => onClickCell(indexOfArray)}
          />
          <StatusSection
            onClickNumber={(number: string) => onClickNumber(number)}
            onClickErase={onClickErase}
            onClickHint={onClickHint}
            onClickCheck={checkErrors}
          />
        </div>

      </div>
      <div className= { overlay
                        ? "overlay overlay--visible"
                        : "overlay"
                      }
           onClick={onClickOverlay}
      >
        <h2 className="overlay__text">
          {won ? "You Won" : "You Lost"}
        </h2>
      </div>
      </GlobalHotKeys>
  );
}
