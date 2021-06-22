import React from 'react';
import Navbar from './Navbar';
import ContentBoundary from "../components/ErrorHandling/ContentBoundary";

export default function withContentBase(WrappedComponent, navbarTitle, navbarActions) {

    if (!navbarTitle) {
        navbarTitle = 'root';
    }

    if (!navbarActions) {
        navbarActions = <></>
    }

    return (props) => {
        return <main className={props.baseClasses.content}>
            <ContentBoundary>
                <Navbar
                    title={navbarTitle}
                    actions={navbarActions}
                    baseClasses={props.baseClasses}
                    toggleMobileOpen={props.toggleMobileOpen}
                />
            </ContentBoundary>
            <ContentBoundary>
                <WrappedComponent {...props} />
            </ContentBoundary>
        </main>
    }
}
