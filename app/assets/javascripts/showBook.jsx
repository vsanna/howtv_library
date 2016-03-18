var SuggestSelectorComponent = Vue.extend({
  'props': ['suggestUrl'],
  'data': {
    'selected_id' : null,
    'current_input' : '',
    'suggests': [],
    'is_loading': false
  },
  'created': function(){},
  'methods' : {
    'select': function(suggest){
      this.$suggestTimer.clear();
      this.selected_id = suggest.id;
      this.$el.querySelector('.suggest-input').value = suggest.name;
      this.suggests = [];
      this.$dispatch('suggest-selected', suggest.id, suggest.name);
    }
  }
});

module.exports = SuggestSelectorComponent;
