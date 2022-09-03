#!/usr/bin/python
class FilterModule(object):
    def filters(self):
        return {
            'keep_last': self._keep_last,
        }

    """
    _keep_last keeps the last n items of a list of lists
    """
    def _keep_last(self, list_of_lists, num_to_keep):
        lists_to_return = []
        for list_items in list_of_lists:
            lists_to_return.append(list_items[0:-num_to_keep])
        return lists_to_return
