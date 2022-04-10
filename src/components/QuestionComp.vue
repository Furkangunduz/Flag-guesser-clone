<template>
	<card-comp />
</template>

<script>
	import countries from '../../country_names';
	import cardComp from '@/components/CardComp.vue';
	const axios = require('axios');
	export default {
		components: {
			cardComp,
		},
		data() {
			return {
				QuestionInfo: {
					country: '',
					index: 0,
					img: '',
					score: '',
				},
				AnswersList: {
					arr: ['', '', '', ''],
				},
			};
		},
		mounted() {
			this.nextFlag();
		},
		methods: {
			nextFlag() {
				if (this.QuestionInfo.index < countries.length - 1) {
					this.getData();
				}
			},
			getData() {
				axios
					.get(`https://restcountries.com/v3.1/name/${countries[this.QuestionInfo.index]}`)
					.then((res) => {
						this.QuestionInfo.country = res.data[0].name.common;
						this.QuestionInfo.img = res.data[0].flags['png'];
						this.QuestionInfo.index < countries.length - 1 ? this.QuestionInfo.index++ : null;
						this.setAnswers();
					});
			},
			setAnswers() {
				let correctIndex = Math.floor(Math.random() * 4);
				this.AnswersList.arr[correctIndex] = this.QuestionInfo.country;
				console.log(correctIndex);
				for (let i = 0; i < 4; i++) {
					if (i != correctIndex) {
						let answer = countries[Math.floor(Math.random() * 10)];
						if (!this.AnswersList.arr.some((i) => i == answer))
							this.AnswersList.arr[i] = answer;
					}
				}
			},
		},
		provide() {
			return {
				nextFlag: this.nextFlag,
				QuestionInfo: this.QuestionInfo,
				AnswersList: this.AnswersList,
			};
		},
	};
</script>
