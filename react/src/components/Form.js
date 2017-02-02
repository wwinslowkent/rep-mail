import React from 'react';

const Form = props => {
 if (props.clicked){
   return(
     <div className="row search">
         <input id="add_review" type='submit' value="Actually, Nevermind" className="btn" onClick={event => {event.preventDefault(), props.handleClicked();}} />
         <form>
           <div className="input-field col s3">
             <input type="text" name="title" placeholder="Enter title here..." onChange={props.handleTitleChange}/>
           </div>
           <div className="input-field col s3">
             <input type="text" name="body" placeholder="Enter body here..." onChange={props.handleBodyChange}/>
           </div>
           <div className="input-field col s3">

           <select value={props.procon} onChange={props.handleProconChange}>
            <option value="true">For</option>
            <option value="false">Against</option>
           </select>

           </div>
           <input type="hidden"  name="userId" value={props.userId} />
           <div className="row">
             <div className="col s2 offset-s5 center-align">
               <input id="add_review" className="btn" type="submit" value="Add Message" name="Submit" onClick={props.handleSubmit}/>
             </div>
           </div>
         </form>
     </div>
   );
 } else {
   return(
   <div className="col search">
     <input id="add-review" type='submit' value="Add New Message" className="btn" onClick={event => {event.preventDefault(), props.handleClicked();}} />
   </div>
 );}
};

export default Form;
