/** @jsx React.DOM */

// Box class:

function makeColourAttribute(i) {
    return "rgb(" + i + ", " + i + ", " + i + ")";
}

var MyBox = React.createClass( {
    render: function () {
        return <div style={ {width: "50px",
                             height: "50px",
                             'background-color':
                                 makeColourAttribute(this.props.brightness)} }></div>;
    }
} );

// A set of boxes (stacked vertically div elements):

var BoxSet = React.createClass( {
    getInitialState: function () {
      return {myBoxes: [
                 <MyBox brightness="128" />,
                 <MyBox brightness="200" />,
                 MyBox({brightness: "0"}),     // An example not in JSX syntax!
                 <MyBox brightness="30" />,
                 <MyBox brightness="80" />]
             };
    },

    destroyBoxes: function () {
        this.setState( {myBoxes: []} );
    },

    addBox: function () {
      var a = this.state.myBoxes;
      a.push(<MyBox brightness="50" />);

      this.setState(
          {myBoxes: a}
      );
    },

    render: function () {
        return <div>
          {this.state.myBoxes}
          <button onClick={this.destroyBoxes}>Destroy!</button>
          <button onClick={this.addBox}>Add a box</button>
        </div>;
    }
});

React.renderComponent(
    <BoxSet />,
    document.getElementById("container")
);
