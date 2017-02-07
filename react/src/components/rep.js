import React from 'react';

const Rep = props => {
  return(
    <div>
      <a href={props.obj.website} > Send to {props.obj.name} </a>
    </div>

  );
};
