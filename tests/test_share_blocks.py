from base import ApiUser, DEV_1_INT, DEV_2_INT, DEV_3_INT
from nose.tools import nottest

#@nottest
class ShareBlocksTest(ApiUser):
    def test(self):
        self.add_peer(DEV_2_INT, [[127, 0, 0, 1], 3010])
        self.add_peer(DEV_1_INT, [[127, 0, 0, 1], 3020])

        self.mine_block(DEV_1_INT, [1, 100000], sleep=0.2)
        self.sync(DEV_1_INT, [[127, 0, 0, 1], 3020], sleep=2.0)

        self.mine_block(DEV_2_INT, [1, 100000], sleep=0.2)
        self.sync(DEV_1_INT, [[127, 0, 0, 1], 3020], sleep =0.2)
    def test_2(self):
        self.mine_block(DEV_1_INT, [50, 100000], sleep=0.5)
        self.sync(DEV_1_INT, [[127, 0, 0, 1], 3020], sleep =0.2)
        self.mine_block(DEV_1_INT, [3, 100000], sleep=0.1)
        self.sync(DEV_1_INT, [[127, 0, 0, 1], 3020], sleep =0.2)
        self.mine_block(DEV_1_INT, [3, 100000], sleep=0.1)
        self.sync(DEV_2_INT, [[127, 0, 0, 1], 3010], sleep =0.2)
        self.sync(DEV_3_INT, [[127, 0, 0, 1], 3010], sleep =0.5)
        self.request("spend", DEV_1_INT, ["BNZHfVU/LskV8GjsI1ASh2rNW2tPp0aVfqTiU9E6ZPCCLZOwBklqDMgclzXzezLwR4WyE1WQa8JBa1TVH+0HzqE=", 10000000000])
        self.mine_block(DEV_1_INT, [1, 100000], sleep=0.02)
        self.sync(DEV_3_INT, [[127, 0, 0, 1], 3010], sleep =0.1)
        self.mine_block(DEV_3_INT, [10, 100000], sleep=0.02)
        self.sync(DEV_1_INT, [[127, 0, 0, 1], 3030], sleep =0.1)
        #Puts money into 1 and 3 because this is a useful situation for testing channels.
