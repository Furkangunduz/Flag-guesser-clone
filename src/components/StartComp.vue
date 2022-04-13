<template>
    <div class="start-page">
        <div class="left">
            <input
                v-model="userName"
                maxlength="8"
                class="input-name"
                type="text"
                placeholder="name"
            />
            <div class="leaderBoard">
                <ul>
                    <li v-for="player of db.board" :key="player.id">
                        <span style="color: white">{{
                            player.username || 'BigBoss'
                        }}</span>
                        :
                        <span style="color: white; font-size: 1.3rem">{{
                            player.score
                        }}</span>
                    </li>
                </ul>
            </div>
        </div>

        <button class="basla-btn" @click="startGame(userName)">Basla</button>
    </div>
</template>
<script>
const axios = require('axios');
export default {
    data() {
        return {
            userName: '',
        };
    },
    inject: ['startGame', 'db'],
};
</script>
<style scoped></style>
