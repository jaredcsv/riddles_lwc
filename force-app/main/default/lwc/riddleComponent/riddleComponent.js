import makeGetCallout from '@salesforce/apex/RiddlesCallout.makeGetCallout';
import { api, LightningElement } from 'lwc';

export default class RiddleComponent extends LightningElement {
    riddle;
    answer;
    showAnswer = false;
    error;

    handleRiddleClick(event) {
        makeGetCallout()
            .then(result => {
                const riddleData = JSON.parse(result);
                this.riddle = riddleData.riddle;
                this.answer = riddleData.answer;
                this.showAnswer = false;
                this.error = undefined;
            })
            .catch(error => {
                this.error = JSON.parse(error.body).error || error.body.message;
                this.riddle = undefined;
                this.answer = undefined;
                this.showAnswer = false;
            });
    }

    handleAnswerClick(event) {
        this.showAnswer = true;
    }
}