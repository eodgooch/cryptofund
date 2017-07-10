import React from 'react';
import ReactDOM from 'react-dom';
import { default as fundData } from 'json/fake-data.json'

class Row extends React.Component {
  render() {
    return <tr>
      <td>{this.props.changeSet.name}</td>
      <td>{this.props.changeSet.description}</td>
      <td>{this.props.changeSet.fundingCurrency}</td>
      <td>{this.props.changeSet.fundingGoal}</td>
      <td>{this.props.changeSet.amount}</td>
      <td>{this.props.changeSet.numOfFunders}</td>
      <td>{this.props.changeSet.endDate}</td>
      <td>{this.props.changeSet.active}</td>
    </tr>;
  }
}

class Rows extends React.Component{
  render() {
    var rows = this.props.changeSets.map(function(changeSet) {
      return(<Row changeSet = {changeSet}/>);
    });
    return ({rows});
  }
}

class App extends React.Component{
  render() {
    return <table className = 'table'>
      <Rows changeSets = {this.props.changeSets} />
    </table>;
  }
}

ReactDOM.render(<App changeSets = {fundData} />, document.getElementById('container'));