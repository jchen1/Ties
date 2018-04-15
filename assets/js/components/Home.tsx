import * as React from 'react'
import { RouteComponentProps } from 'react-router-dom'
import { Button, Form, FormGroup, Label, Input } from 'reactstrap'

interface Tie {
  id: number
  first_name: string
  last_name: string
  last_conversation: string
  tags: { id: number, name: string }[]
}

interface CreateTieFormProps {
  addTie(tie: Tie): void
}

interface CreateTieFormState {
  error: string
  first_name: string
  last_name: string
}

class CreateTieForm extends React.Component<CreateTieFormProps, CreateTieFormState> {
  constructor(props) {
    super(props);
    this.state = {error: '', first_name: '', last_name: ''};

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    fetch('/api/v1/ties', {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        first_name: this.state.first_name,
        last_name: this.state.last_name
      })
    })
      .then(response => response.json() as Promise<Tie>)
      .then(data => this.props.addTie(data))
  }

  handleChange(propName, event) {
    const value = event.target.value;
    this.setState(prevState => ({
      error: prevState.error,
      first_name: propName === 'first_name' ? value : prevState.first_name,
      last_name: propName === 'last_name' ? value : prevState.last_name,
    }));
  }

  render() {
    return (
      <Form onSubmit={this.handleSubmit}>
        <Label>
          First name:
          <Input type="text" value={this.state.first_name} onChange={this.handleChange.bind(this, 'first_name')} />
        </Label>
        <Label>
          Last name:
          <Input type="text" value={this.state.last_name} onChange={this.handleChange.bind(this, 'last_name')} />
        </Label>
        <Button type="submit" value="Submit">Submit</Button>
      </Form>
    )
  }
}

interface ICreateTagProps {
  tie: Tie
  addTag(tagName: string): void
}

interface ICreateTagState {
  name: string
}

class CreateTagForm extends React.Component<ICreateTagProps, ICreateTagState> {
  constructor(props) {
    super(props)
    this.state = { name: '' }
    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleSubmit(event) {
    event.preventDefault();

    const { id } = this.props.tie;
    fetch(`/api/v1/ties/${id}/tags`, {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: this.state.name
      })
    }).then(() => this.props.addTag(this.state.name))
      .then(() => this.setState({ name: '' }));
  }

  handleChange(event) {
    this.setState({ name: event.target.value });
  }

  render() {
    return (
      <Form onSubmit={this.handleSubmit}>
        <FormGroup>
          <Label for="addTag">Add new tag...</Label>
          <Input type="text" name="text" id="addTag" onChange={this.handleChange} value={this.state.name}></Input>
        </FormGroup>
        <Button>Submit</Button>
      </Form>
    );
  }
}

interface HomeState {
  loading: boolean
  ties: Tie[]
}

export default class Home extends React.Component<{}, HomeState> {
  constructor(props) {
    super(props)
    this.state = { ties: [], loading: true }

    fetch('/api/v1/ties')
      .then(response => response.json() as Promise<Tie[]>)
      .then(data => this.setState({ ties: data, loading: false }))
  }

  public updateConversation(index: number, e) {
    const { id } = this.state.ties[index];
    fetch(`/api/v1/ties/${id}`, {
      method: 'PUT',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        last_conversation: Math.floor(Date.now() / 1000)
      })
    })
      .then(response => response.json() as Promise<Tie>)
      .then(data => this.setState({ ties: this.state.ties.map((t, i) => i == index ? data : t) }));
  }

  public addTie(tie: Tie) {
    this.setState({ ties: this.state.ties.concat(tie) });
  }

  public addTag(index: number, name: string) {
    const newTie = {...this.state.ties[index],
                    tags: this.state.ties[index].tags.concat({ id: -1, name })}
    this.setState({ ties: this.state.ties.map((t, i) => i == index ? newTie : t)});
  }

  public deleteTie(index: number) {
    const { id } = this.state.ties[index];
    fetch(`/api/v1/ties/${id}`, {
      method: 'DELETE'
    }).then(() => this.setState({ ties: [...this.state.ties.slice(0, index), ...this.state.ties.slice(index + 1)] }));
  }

  public render(): JSX.Element {
    return this.state.loading
    ? (
      <p>
        <em>Loading...</em>
      </p>
    )
    : (
      <div>
        <h1>Ties</h1>
        {this.state.ties.map((tie, index) =>
          <div>
            <h2>{tie.first_name} {tie.last_name}</h2>
            <h3>Last talked: {tie.last_conversation}</h3>
            <h4>Tags:</h4>
            <div>
              {tie.tags.map(({ name }) => <span>{name}<br/></span>)}
              <CreateTagForm tie={tie} addTag={this.addTag.bind(this, index)} ></CreateTagForm>
            </div>
            <Button color="primary" onClick={this.updateConversation.bind(this, index)}>Just talked...</Button>
            <Button color="danger" onClick={this.deleteTie.bind(this, index)}>Delete...</Button>
          </div>
        )}
        <CreateTieForm addTie={this.addTie.bind(this)} />
      </div>
    )
  }
}