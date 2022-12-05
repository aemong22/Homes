<template>
  <b-tr class="text-center">
    <b-td>{{ no }}</b-td>
    <b-td>{{ userId }}</b-td>
    <b-td>{{ userPwd }}</b-td>
    <b-td>{{ userName }}</b-td>
    <b-td>{{ address }}</b-td>
    <b-td>{{ emailId }}@{{ emailDomain }}</b-td>
    <b-td>{{ phonenumber }}</b-td>
    <b-td>{{ admin }}</b-td>
    <b-td>
      <b-button
        variant="danger"
        type="button"
        @click="handleDelete"
        size="sm"
        class="mx-1"
        ><b-icon icon="trash"></b-icon
      ></b-button>
      <b-button variant="primary" type="button" v-b-modal="userId" size="sm"
        ><b-icon icon="pencil-square"></b-icon
      ></b-button>
      <b-modal :id="userId" hide-footer centered title="회원 정보 수정">
        <admin-edit
          :userId="userId"
          :userPwd="userPwd"
          :userName="userName"
          :address="address"
          :emailId="emailId"
          :emailDomain="emailDomain"
          :phonenumber="phonenumber" />
      </b-modal>
    </b-td>
  </b-tr>
</template>

<script>
import { mapActions } from "vuex";
import AdminEdit from "@/components/user/include/AdminUserEdit";

const memberStore = "memberStore";

export default {
  // 부모 component로 부터 전달받은 도서정보
  props: {
    no: String,
    userId: String,
    userPwd: String,
    userName: String,
    address: String,
    emailId: String,
    emailDomain: String,
    phonenumber: String,
    admin: Boolean,
  },
  components: {
    AdminEdit,
  },
  methods: {
    ...mapActions(memberStore, ["adminDeleteUser", "getUsers"]),
    handleDelete() {
      this.$fire({
        title: "Confirm",
        text: this.userId + " 정보를 삭제하시겠습니까?",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes",
      }).then((result) => {
        console.log(result);
        if (result.value) {
          const payload = {
            userId: this.userId,
            callback: () => {
              this.getUsers();
            },
          };
          this.adminDeleteUser(payload);
        }
      });
    },
  },
};
</script>

<style scope>
tbody > tr {
  font-size: 13px;
}
td {
  border-color: #ffffff !important;
}
th {
  font-size: 14px;
  background-color: #ffffff !important;
}
</style>
