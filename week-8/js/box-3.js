/** @jsx React.DOM */

// Box class:

function makeColourAttribute(i) {
    return "rgb(" + i + ", " + i + ", " + i + ")";
}

var MyBox = React.createClass( {
    deleteMe: function () {
    },

    render: function () {
      var rgb = makeColourAttribute("0");

        if (this.props.brightness !== undefined) {
            rgb = makeColourAttribute(this.props.brightness);
        } else if (this.props.colour !== undefined) {
            rgb = this.props.colour;
        } else {
            rgb = "rgb(255, 0, 0)";
        }

        return <div style={ {width: "100px",
                             height: "50px",
                           'background-color': rgb} }><button onClick={this.deleteMe}>Delete me!</button></div>;
    }
} );

// A set of boxes (stacked vertically div elements):

var BoxSet = React.createClass( {
    getInitialState: function () {
      return {myBoxes: [
                 <MyBox />,
                 <MyBox colour="rgb(255, 100, 0)" />,
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

var myBoxSet = <BoxSet />;

React.renderComponent(
    myBoxSet,
    document.getElementById("container")
);
