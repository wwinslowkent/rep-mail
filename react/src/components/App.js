import React, { Component } from 'react';
import Message from './Message';
import Form from './Form';


class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      messages: [],
      message: "",
      title: "",
      body: "",
      procon: true,
      clicked: false,
      user: null,
      messageUsers: [],
      isAdmin: false,
      revealedKey: null,

    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleBodyChange = this.handleBodyChange.bind(this);
    this.handleClicked = this.handleClicked.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
    this.handleEditClicked = this.handleEditClicked.bind(this);
    this.parseTime = this.parseTime.bind(this);
    this.handleUpVote = this.handleUpVote.bind(this);
    this.handleDownVote = this.handleDownVote.bind(this);
    this.handleProconChange = this.handleProconChange.bind(this);
    this.handleTitleChange = this.handleTitleChange.bind(this);
  }



  parseTime(time) {
    let firstSplit = time.split("-");
    let year = firstSplit[0];
    let month = firstSplit[1];
    let rest = firstSplit[2].split("T");
    let day = rest[0];
    let hms = rest[1].split(":");
    let hour = hms[0];
    let minute = hms[1];

    if (hour < 5) {
      hour = hour + 19;
    }
    else {
      hour = hour - 5;
    }
    let ampm = "";
    if (hour > 12) {
      hour = hour - 12;
      ampm = "PM";
    }
    else {
      ampm = "AM";
    }
    let returnString = `${hour}:${minute}${ampm}, ${month}/${day}/${year}`;
    return returnString;

  }


  handleProconChange(event) {
    console.log(event.target.value);
    console.log("hey");
    this.setState({ procon: event.target.value });
  }

  handleEditClicked(messageId) {
    if (messageId != this.state.revealedKey) {
      this.setState({revealedKey: messageId});
    } else {
      this.setState({revealedKey: null});
    }
  }

  handleClicked(event) {
    if (this.state.clicked === false){
      this.setState({clicked: true});
    } else {
      this.setState({clicked: false});
    }
  }

  handleBodyChange(event) {
    console.log(this.state.body);
    let newBody = event.target.value;
    this.setState({ body: newBody });
  }

  handleTitleChange(event) {
    console.log(event.target.value);
    let newTitle = event.target.value;
    console.log(newTitle);
    this.setState({ title: newTitle });
  }

  handleEdit(messageId) {
    let pageId = parseInt(document.getElementById('app').dataset.id);
    event.preventDefault();
    let fetchBody = { title: this.state.title,  body: this.state.body, procon: this.state.procon, id: messageId, type: "update", billId: pageId };
    let newMessages = [];
    fetch(`../api/v1/bills/${pageId}/messages/${messageId}`,
      { method: "PATCH",
      body: JSON.stringify(fetchBody) })
      .then(function(response) {
        newMessages = response.json();
        return newMessages;
      }).then((response) => {
      this.setState({
        messages: response.messages,
        procon: true,
        title: "",
        body: "",
        messageUsers: response.users
      });
      }
    );
  }

  handleUpVote(messageId) {
    let pageId = parseInt(document.getElementById('app').dataset.id);

    event.preventDefault();
    let fetchBody = { id: messageId, type: "upvote", userId: this.state.user.id};
    let newMessages = [];
    fetch(`../api/v1/bills/${pageId}/messages/${messageId}`,
      { method: "PATCH",
      body: JSON.stringify(fetchBody) })
      .then(function(response) {
        newMessages = response.json();
        return newMessages;
      }).then((response) =>
      this.setState({ messages: response.messages, messageUsers: response.users })
    );
  }

  handleDownVote(messageId) {
    let pageId = parseInt(document.getElementById('app').dataset.id);
    event.preventDefault();
    let fetchBody = { id: messageId, type: "downvote", userId: this.state.user.id };
    let newMessages = [];
    fetch(`../api/v1/bills/${pageId}/messages/${messageId}`,
      { method: "PATCH",
      body: JSON.stringify(fetchBody) })
      .then(function(response) {
        newMessages = response.json();
        return newMessages;
      }).then((response) =>
      this.setState({ messages: response.messages, messageUsers: response.users })
    );
  }

  handleSubmit(event) {
    let pageId = parseInt(document.getElementById('app').dataset.id);
    event.preventDefault();
    let fetchBody = { title: this.state.title,  body: this.state.body, userId: this.state.user.id, procon: this.state.procon };
    let newMessages = [];
  //  let newUserArr = this.state.messageUsers;
    //newUserArr.push(this.state.user);
    fetch(`../api/v1/bills/${pageId}/messages`,
      { method: "POST",
      body: JSON.stringify(fetchBody) })
      .then(function(response) {
        newMessages = response.json();
        return newMessages;
      }).then((response) =>
      this.setState({
        messages: response.messages,
        title: "",
        message: "",
        clicked: false,
        procon: true,
        messageUsers: response.users
      })
    );
  }

  handleDelete(messageId){
    let fetchBody = { id: messageId };
    let newMessages = [];
    let pageId = parseInt(document.getElementById('app').dataset.id);
    fetch(`/api/v1/bills/${pageId}/messages/${messageId}`,
    { method: "DELETE",
    body: JSON.stringify(fetchBody)
  }).then(function(response){
    newMessages = response.json();
    return newMessages;
  })
  .then((response) => this.setState({ messages: response.messages, messageUsers: response.users }));
  }

  componentDidMount(){
    let pageId = parseInt(document.getElementById('app').dataset.id);
    $.ajax({
      credentials: 'same-origin',
      method: "GET",
      url: `../api/v1/bills/${pageId}.json`
    })
    .done(data => {
      this.setState({
        messages: data.messages,
        user: data.user,
        messageUsers: data.messageUsers,
        isAdmin: data.isAdmin,
      });
    });
  }

  render() {
    let clicked = this.state.clicked;
    let currentUser = this.state.user;
    let userName;
    let userId;
    let counter = -1;
    let messageUsers = this.state.messageUsers;
    let isAdmin = this.state.isAdmin;
    let revealedKey = this.state.revealedKey;
    let revealedEdit;
    let procon = this.state.procon;


    if (this.state.user !== null) {
      userId = this.state.user.id;
      userName = this.state.user.name;
    }
    else {
      userId = 0;
      userName = "test";
    }

    let messages = this.state.messages.map(message => {
      let createdAt = this.parseTime(message.created_at);
      if (message.id == revealedKey) {
        revealedEdit = true;
      }
      else {
        revealedEdit = false;
      }
      let handleUpVote = () => {
        this.handleUpVote(message.id);
      };
      let handleDownVote = () => {
        this.handleDownVote(message.id);
      };

      let handleDelete = () => {
        this.handleDelete(message.id);
      };

      let handleEdit = () => {
        this.handleEdit(message.id);
      };
      counter++;
      let messageUserHolder;

      if (counter >=  messageUsers.length) {
        messageUserHolder = message.user_id;
      }
      else {
        messageUserHolder = messageUsers[counter].name;
      }
        return(
          <Message
          key={message.id}
          id={message.id}
          message={message.message}
          username={messageUserHolder}
          messageUser={message.user_id}
          isAdmin={isAdmin}
          userId ={userId}
          handleDelete={handleDelete}
          handleEdit={handleEdit}
          handleTitleChange={this.handleTitleChange}
          handleBodyChange={this.handleBodyChange}
          onClickFunction={this.handleEditClicked}
          revealed={revealedEdit}
          createdAt={createdAt}
          handleUpVote={handleUpVote}
          handleDownVote={handleDownVote}
          vote={message.vote}
          title={message.title}
          body={message.body}



          />
        );
    });
    if (this.state.user !== null) {
    return(

      <div>
        <Form
          handleSubmit={this.handleSubmit}
          handleTitleChange={this.handleTitleChange}
          handleBodyChange={this.handleBodyChange}
          handleClicked={this.handleClicked}
          handleProconChange={this.handleProconChange}
          clicked={clicked}
          userId={userId}
          procon={procon}
        />
        {messages}

        </div>
        );
      }
      else {
        return (
        <div>
          {messages}
          </div>
        );
      }




  }
}


export default App;
