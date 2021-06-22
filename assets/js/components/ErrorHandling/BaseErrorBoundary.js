import React from 'react';

export default function withErrorBoundary(WrappedComponent) {
    return class extends React.Component {
        constructor(props) {
            super(props);
            this.state = {hasError: false};
        }

        static getDerivedStateFromError(error) {
            return {hasError: true};
        }

        componentDidCatch(error, errorInfo) {
            //TODO: also send error to server
            console.error(error, errorInfo);
        }

        render() {
            return <WrappedComponent hasError={this.state.hasError} {...this.props}/>
        }
    }
}
