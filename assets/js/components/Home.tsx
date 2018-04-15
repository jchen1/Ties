import * as React from 'react'
import { RouteComponentProps } from 'react-router-dom'
import { Jumbotron, Button, Row, Col } from 'reactstrap'

interface Tie {
  id: number
  first_name: string
  last_name: string
  last_conversation: string
}

interface CreateTieFormState {
  error: string
  first_name: string
  last_name: string
}

class CreateTieForm extends React.Component<{}, CreateTieFormState> {

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

  public render(): JSX.Element {
    // const content = this.state.loading ? <p><em>Loading...</em></p>
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
            <h3>{tie.last_conversation}</h3>
            <button onClick={this.updateConversation.bind(this, index)}>Just talked...</button>
          </div>
        )}
        <div className="">
          <button></button>
        </div>
      </div>
    )
  }
}