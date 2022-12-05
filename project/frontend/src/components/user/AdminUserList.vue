<template>
  <div class="bv-example-row mt-3">
    <b-row align-h="center">
      <b-col class="col-sm col-md-8 col-lg-8">
        <b-form-input
          size="sm"
          class="rounded"
          type="text"
          v-model="filterText"></b-form-input>
      </b-col>
    </b-row>
    <b-row class="mb-1">
      <b-col class="text-right" v-b-modal.admin-join-modal>
        <b-button size="sm" style="background-color: white">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            style="fill: rgba(0, 0, 0, 1); transform: ; msfilter: ">
            <path
              d="M19 8h-2v3h-3v2h3v3h2v-3h3v-2h-3zM4 8a3.91 3.91 0 0 0 4 4 3.91 3.91 0 0 0 4-4 3.91 3.91 0 0 0-4-4 3.91 3.91 0 0 0-4 4zm6 0a1.91 1.91 0 0 1-2 2 1.91 1.91 0 0 1-2-2 1.91 1.91 0 0 1 2-2 1.91 1.91 0 0 1 2 2zM4 18a3 3 0 0 1 3-3h2a3 3 0 0 1 3 3v1h2v-1a5 5 0 0 0-5-5H7a5 5 0 0 0-5 5v1h2z"></path>
          </svg>
          <span style="color: black">회원추가</span>
        </b-button>
      </b-col>
      <b-modal
        id="admin-join-modal"
        hide-header
        hide-footer
        centered
        title="회원가입">
        <user-join type="admin" />
      </b-modal>
    </b-row>
    <b-row>
      <b-col v-if="users.length">
        <b-table-simple hover responsive>
          <b-thead head-variant="light">
            <b-tr class="text-center">
              <b-th>번호</b-th>
              <b-th>ID</b-th>
              <b-th>NAME</b-th>
              <b-th>PWD</b-th>
              <b-th>ADDRESS</b-th>
              <b-th>E-MAIL</b-th>
              <b-th>PHONE</b-th>
              <b-th>ADMIN</b-th>
              <b-th>BUTTON</b-th>
            </b-tr>
          </b-thead>
          <tbody>
            <list-row
              v-for="(user, index) in searchFiltered"
              :key="index"
              :no="`${index + 1}`"
              :userId="user.userId"
              :userPwd="user.userPwd"
              :userName="user.userName"
              :address="user.address"
              :emailId="user.emailId"
              :emailDomain="user.emailDomain"
              :phonenumber="user.phonenumber"
              :admin="user.admin"
              :user="user"></list-row>
          </tbody>
        </b-table-simple>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import { mapActions, mapState } from "vuex";
import UserJoin from "@/components/user/UserRegister.vue";

const memberStore = "memberStore";

export default {
  data() {
    return {
      filterText: "",
    };
  },
  components: {
    "list-row": () => import("@/components/user/include/ListRow.vue"),
    UserJoin,
  },
  methods: {
    ...mapActions(memberStore, ["getUsers"]),
  },
  created() {
    this.getUsers();
  },
  computed: {
    ...mapState(memberStore, ["users"]),
    searchFiltered() {
      return this.users.filter((user) => {
        return user.userId.match(this.filterText);
      });
    },
  },
};
</script>

<style></style>
