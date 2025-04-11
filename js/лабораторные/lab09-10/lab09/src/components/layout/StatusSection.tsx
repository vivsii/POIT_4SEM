import React from 'react';
import { Numbers } from '../Numbers';

type StatusSectionProps = {
  onClickNumber: (number: string) => void,
  onClickErase: () => void,
  onClickHint: () => void,
  onClickCheck: () => void
};


export const StatusSection = (props: StatusSectionProps) => {
  return (
    <section className="status">
      <Numbers onClickNumber={(number) => props.onClickNumber(number)} />
        <div className="status__actions">
            <button onClick={props.onClickHint}>Подсказка</button>
            <button onClick={props.onClickCheck}>Проверка</button>
        </div>
    </section>
  )
}
