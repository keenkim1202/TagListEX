import UIKit
import SnapKit

class TagViewController: UIViewController {
    let tagView = TagView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.addSubview(tagView)
        let safeArea = self.view.safeAreaLayoutGuide
        tagView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        // test용 데이터
        ["안녕하세요", "저는", "iOS 개발자", "취업준비생", "입니다", "빨리 취업이 되면", "좋겠네요.", "아무나 붙여주세요", "나같은 인재를 놓치시면 손해입니다"].forEach{ tagView.addTag(tag: $0) }
    }
}

class TagView: UIView {
    /// 태그 버튼을 저장할 배열
    private var tagButtons = [UIButton]()
    /// 버튼 간 가로 간격
    private let horizontalSpacing: CGFloat = 10
    /// 버튼 간 세로 간격
    private let verticalSpacing: CGFloat = 10
    /// 버튼의 높이
    private let tagHeight: CGFloat = 30

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// 버튼이 클릭됐을 때 호출되는 메서드
    @objc private func buttonClicked(sender: UIButton) {
        print("Button clicked")
    }

    /// 태그를 추가하는 메서드
    func addTag(tag: String) {
        let tagButton = UIButton()
        tagButton.setTitle(tag, for: .normal)
        tagButton.backgroundColor = .lightGray
        tagButton.layer.cornerRadius = 5
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        tagButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        self.addSubview(tagButton)
        tagButtons.append(tagButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var xOffset: CGFloat = horizontalSpacing
        var yOffset: CGFloat = verticalSpacing
        let maxWidth = self.frame.width
        
        tagButtons.forEach { button in
            /// 20은 내부 여백
            let buttonSize = button.intrinsicContentSize.width + 20
            
            /// 현재 줄에 버튼이 맞지 않으면 다음 줄로 이동
            if xOffset + buttonSize + horizontalSpacing > maxWidth {
                xOffset = horizontalSpacing
                yOffset += tagHeight + verticalSpacing
            }
            
            /// 버튼의 프레임 설정
            button.frame = CGRect(x: xOffset, y: yOffset, width: buttonSize, height: tagHeight)
            
            /// 다음 버튼의 x 오프셋 업데이트
            xOffset += buttonSize + horizontalSpacing
        }
    }
}
