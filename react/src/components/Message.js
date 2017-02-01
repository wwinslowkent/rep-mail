import React from 'react';

const Message = props => {
  let buttonClick = () => props.onClickFunction(props.id);

  if(props.userId === props.messageUser) {
    if (props.revealed){
      return(
        <div>
        <br/>
        <input id="delete" className="button tiny button hollow button success" type="submit" value="Up Vote" name="Delete" onClick={props.handleUpVote}/> &#8196;&#8196;&#8196;&#8196;&#8196;&#8196; {props.title}<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;{props.upVotes - props.downVotes}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;{props.body}<br/>
        <input id="delete" className="button tiny button hollow button alert" type="submit" value="Down Vote" name="Delete" onClick={props.handleDownVote}/>&#8196;&#8196;&#8196;&#8196;&#8196;<h9>Posted at {props.createdAt}</h9>

        <div className="col s2 offset-s5 center-align">
          <input id="delete" className="btn" type="submit" value="Delete" name="Delete" onClick={buttonClick}/>
        </div>

        <div className="row search">
              <input id="edit_message" type='submit' value="Actually, Nevermind" className="btn" onClick={buttonClick} />
            <form>
              <div className="input-field col s3">
                <input type="text" name="title" defaultValue={props.title} onChange={props.handleTitleChange}/>
              </div>
              <div className="input-field col s3">
                <input type="text" name="body" defaultValue={props.body} onChange={props.handleBodyChange}/>
              </div>
              <div className="row">
                <div className="col s2 offset-s5 center-align">
                  <input id="add_message" className="btn" type="submit" value="Change Message" name="Submit" onClick={props.handleEdit}/>
                </div>
              </div>
            </form>
        </div>
        <hr/>
      </div>
      );
    } else {
      return(
        <div>
        <br/>
        <input id="delete" className="button tiny button hollow button success" type="submit" value="Up Vote" name="Delete" onClick={props.handleUpVote}/> &#8196;&#8196;&#8196;&#8196;&#8196;&#8196; {props.title}<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;{props.upVotes - props.downVotes}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;{props.body}<br/>
        <input id="delete" className="button tiny button hollow button alert" type="submit" value="Down Vote" name="Delete" onClick={props.handleDownVote}/>&#8196;&#8196;&#8196;&#8196;&#8196;<h9>Posted at {props.createdAt}</h9>

        <div className="col s2 offset-s5 center-align">
          <input id="delete" className="btn" type="submit" value="Delete" name="Delete" onClick={props.handleDelete}/>     <input id="add-message" type='submit' value="Edit Message" className="btn" onClick={buttonClick} />
        </div>
        <br/>
      <hr/>
    </div>
    );
  }
  }
  else if(props.isAdmin) {
    return(
      <div>
      <br/>
      <input id="delete" className="button tiny button hollow button success" type="submit" value="Up Vote" name="Delete" onClick={props.handleUpVote}/> &#8196;&#8196;&#8196;&#8196;&#8196;&#8196; {props.title}<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;{props.upVotes - props.downVotes}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;{props.body}<br/>
      <input id="delete" className="button tiny button hollow button alert" type="submit" value="Down Vote" name="Delete" onClick={props.handleDownVote}/>&#8196;&#8196;&#8196;&#8196;&#8196;<h9>Posted at {props.createdAt}</h9>

        <div className="col s2 offset-s5 center-align">
          <input id="delete" className="btn" type="submit" value="Delete" name="Delete" onClick={props.handleDelete}/>
        </div>
        <hr/>
      </div>
    );

  }
  else if(props.userId != 0 ) {
    return(
      <div>
      <br/>
      <input id="delete" className="button tiny button hollow button success" type="submit" value="Up Vote" name="Delete" onClick={props.handleUpVote}/> &#8196;&#8196;&#8196;&#8196;&#8196;&#8196; {props.title}<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;{props.upVotes - props.downVotes}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;&#8196;{props.body}<br/>
      <input id="delete" className="button tiny button hollow button alert" type="submit" value="Down Vote" name="Delete" onClick={props.handleDownVote}/>&#8196;&#8196;&#8196;&#8196;&#8196;<h9>Posted at {props.createdAt}</h9>
        <hr/>
      </div>
    );
  }
  else {
    return(
      <div>
        {props.title}<br/>
      {props.body}
        <h9>Posted at {props.createdAt}</h9>

        <hr/>
      </div>
    );
  }
};







export default Message;
